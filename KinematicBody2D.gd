extends KinematicBody2D
var velocidade = Vector2.ZERO
var move_speed = 800
var gravity =  1200
var jump_force = -1120
var is_grounded
onready var raycasts = $raycasts
var vida = 3
var machucado = false

var impulso_direcao = 1
var impulso_int = 3000

func _physics_process(delta: float) -> void:
	velocidade.y+= gravity * delta
	_get_input()
	
	velocidade = move_and_slide(velocidade)
	
	is_grounded = _check_is_ground()
	
	_set_animation()
	
	
	for plataforma in get_slide_count():
		var colisao = get_slide_collision(plataforma)
		if colisao.collider.has_method("collide_with"):
			colisao.collider.collide_with(colisao, self)
	
func _get_input():
	velocidade.x = 0
	var move_direction = int (Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")) 
	
	velocidade.x = lerp(velocidade.x, move_speed * move_direction, 0.2)
	
	if move_direction !=0:
		$Sprite.scale.x = move_direction
		impulso_direcao = move_direction


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_grounded:
		velocidade.y = jump_force /2
		
func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
	return false

func _set_animation():
	
	var anim = "Idle"
	
	if !is_grounded:
		if velocidade.y < 0:
			anim = "subirpulo"
		if velocidade.y > 0:
			anim = "cairpulo"
	elif velocidade.x !=0:
		anim = "frame"
	
	if machucado:
		anim = "machuquei"	
	
	if $AnimationPlayer.assigned_animation !=anim:
		$AnimationPlayer.play(anim)

func impulso():
	velocidade.x = -impulso_direcao * impulso_int
	velocidade = move_and_slide(velocidade)
	
	
func _on_Receberdano_body_entered(body):
	vida -= 1
	machucado = true
	impulso()
	yield(get_tree().create_timer(0.5), "timeout")
	machucado = false
	if vida < 1:
		queue_free()
		get_tree().reload_current_scene()
