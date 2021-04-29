extends Node

var roar = load("res://music/monster2.wav")

func _ready():
	pass


func play_sound():
	$roar.stream = roar
	$roar.play()
