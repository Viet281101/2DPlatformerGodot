extends Control


onready var gener = $TextCredit.rect_position.y

func _ready():
	pass

func _process(delta):
	$TextCredit.rect_position.y -= 0.5
	if gener < 0:
		$TextCredit.rect_position = 100

func _on_Return_pressed():
	get_tree().change_scene("res://Menu.tscn")
