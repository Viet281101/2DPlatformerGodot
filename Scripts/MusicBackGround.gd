extends Node

var background_music = load("res://music/aztec-temple.wav")


func _ready():
	pass


func play_music():
	$AztecTemple.stream = background_music
	$AztecTemple.play()
