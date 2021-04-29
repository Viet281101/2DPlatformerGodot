extends Node

var roar = load("res://music/monster_echo.wav")

func _ready():
	pass

func play_sound():
	$monster_echo.stream = roar
	$monster_echo.play()
