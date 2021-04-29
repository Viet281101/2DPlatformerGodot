extends Node

var hurt_sound = load("res://music/hurt_sound.wav")

func _ready():
	pass

func play_sound():
	$hurtSound.stream = hurt_sound
	$hurtSound.play()
