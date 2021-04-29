extends Control


func _ready():
	pass


func _on_Start_pressed():
	get_tree().change_scene("res://Level 1.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Credit_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")


func _on_Intro_pressed():
	get_tree().change_scene("res://Scenes/Intro.tscn")
