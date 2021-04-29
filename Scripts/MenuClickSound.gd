extends Node

var click_sound = load("res://music/Menu Select.wav")

func play_music():
	$MenuSelectMusic.stream = click_sound
	$MenuSelectMusic.play()
