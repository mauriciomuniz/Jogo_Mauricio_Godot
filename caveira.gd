extends KinematicBody2D

export var speed = 100
export var vida = 1
var velocity = Vector2.ZERO
var move_direction = -1 
var gravity = 1200
var atacado = false

func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction
	velocity.y= gravity *delta
	velocity = move_and_slide(velocity)
	
	if move_direction == 1:
		$Sprite.flip_h = false
	else: 
		$Sprite.flip_h = true
	_set_animation()
	


func _on_anim_animation_finished(anim_name: String) -> void:
	if anim_name == "Parado":
		$Sprite.flip_h != $Sprite.flip_h
		$ray_parede.scale.x *= -1
		move_direction *= -1
		$anim.play("correr")

func _set_animation():
	
	var anim = "correr"
	
	if $ray_parede.is_colliding():
		anim = "Parado"
	elif velocity.x !=0:
		anim = "correr"
	if atacado == true:
		anim = "morre"		
	
	if $anim.assigned_animation !=anim:
		$anim.play(anim)


func _on_bateinimigo_body_entered(body: Node)-> void:
	atacado = true
	vida -=1
	body.velocidade.y -=300
	yield(get_tree().create_timer(1),"timeout")
	atacado = false
	if vida < 1:
		queue_free()
		get_node("bateinimigo/CollisionShape2D").set_deferred("disable",true)
