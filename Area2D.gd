extends Area2D




func _on_Area2D_body_entered(body: Node)->void:
	print("morreu")
	get_tree().reload_current_scene()
