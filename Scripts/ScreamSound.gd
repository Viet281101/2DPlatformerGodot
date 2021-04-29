extends Node

var scream = load("res://music/nmh_scream1.wav")

func _ready():
	pass

func play_scream():
	$scream.stream = scream
	$scream.play()
