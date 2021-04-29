extends CanvasLayer

onready var title = $PanelContainer/MarginContainer/Rows/Title

func _ready():
	pass

#func set_title():
#	if win:
#		title.text = "YOU WIN"
#	else:
#		title.text = "YOU LOSE"

func _on_RestartButton_pressed():
	MenuClickSound.play_music()
	get_tree().change_scene("res://Level 1.tscn")


func _on_QuitButton_pressed():
	MenuClickSound.play_music()
	get_tree().quit()




func _on_GoToMenu_pressed():
	MenuClickSound.play_music()
	get_tree().change_scene("res://Menu.tscn")
