extends CanvasLayer

var coin = 0

func _ready():
	$coins.text = String(coin) 

func _physics_process(delta):
	if coin == 9:
		get_tree().change_scene("res://Level 1.tscn")

func _on_coin_collected():
	coin += 1
	_ready()


func _on_coin_coin_collected():
	coin += 1
	_ready()
