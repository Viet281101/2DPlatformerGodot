extends Node

var move = load("res://music/Swipe.wav")

func _ready():
	pass

func play_sound():
	$Sound.stream = move
	$Sound.play() 
