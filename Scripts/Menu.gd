extends Control


func _ready():
	MusicBackGround.play_music()


func _on_Start_pressed():
	MenuClickSound.play_music()
	get_tree().change_scene("res://Level 1.tscn")


func _on_Quit_pressed():
	MenuClickSound.play_music()
	get_tree().quit()


func _on_Credit_pressed():
	MenuClickSound.play_music()
	get_tree().change_scene("res://Scenes/Credits.tscn")


func _on_Intro_pressed():
	MenuClickSound.play_music()
	get_tree().change_scene("res://Scenes/Intro.tscn")
