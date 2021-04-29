extends Node

var shoot = load("res://music/attack_sound.wav")

func _ready():
	pass

func play_sound():
	$shoot.stream = shoot
	$shoot.play()
