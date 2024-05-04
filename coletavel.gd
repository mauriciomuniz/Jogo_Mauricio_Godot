extends Area2D


func _on_coletavel_body_entered(body):
	print("pegou a moeda")
	$anim.play("termina")


func _on_anim_animation_finished(anim_name: String) -> void:
	if anim_name == "termina":	
		queue_free()
