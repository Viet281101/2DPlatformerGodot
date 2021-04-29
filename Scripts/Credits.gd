extends Control


onready var gener = $TextCredit.rect_position.y

func _ready():
	MusicBackGround.play_music()

func _process(delta):
	$TextCredit.rect_position.y -= 0.5
	if gener < 0:
		$TextCredit.rect_position = 100

func _on_Return_pressed():
	MenuClickSound.play_music()
	get_tree().change_scene("res://Menu.tscn")
