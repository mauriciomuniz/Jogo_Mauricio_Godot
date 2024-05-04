extends Control

func _ready():
	$controles/botaoStart.grab_focus()


func _on_botaoStart_pressed():
	get_tree().change_scene("res://Mundo.tscn")


func _on_botaoControles_pressed():
	var Teladecontrole = load("res://Teladecontrole.tscn").instance()
	get_tree().current_scene.add_child(Teladecontrole)


func _on_botaoSobre_pressed():
	var Sobre = load("res://Sobre.tscn").instance()
	get_tree().current_scene.add_child(Sobre)


func _on_botaoSair_pressed():
	get_tree().quit()
