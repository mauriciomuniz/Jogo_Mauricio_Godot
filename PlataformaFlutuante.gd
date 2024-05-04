extends KinematicBody2D

onready var anim = $anim
onready var timer = $timer

onready var reset_position = global_position

var velocidade = Vector2.ZERO
var gravidade = 720
var gatilho = false
export var reset_timer = 3.0

func _ready():
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	velocidade.y+= gravidade * delta
	position += velocidade*delta

func collide_with(collision: KinematicCollision2D, collider:KinematicBody2D):
	if !gatilho:
		gatilho = true
		anim.play("mexe")
		velocidade = Vector2.ZERO

func _on_anim_animation_finished(anim_name):
	set_physics_process(true)
	timer.start(reset_timer)

func _on_timer_timeout():
	set_physics_process(false)
	yield(get_tree(), "physics_frame")
	var temp = collision_layer
	collision_layer = 0
	global_position = reset_position
	yield(get_tree(), "physics_frame")
	collision_layer = temp
	gatilho = false
