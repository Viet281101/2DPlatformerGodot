extends Area2D

var blink = load("res://music/move.wav")

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			$AnimationPlayer.play("active")
			$blink.stream = blink
			$blink.play()
			yield($AnimationPlayer,"animation_finished")
			$AnimationPlayer.play("idle")
		else:
			$AnimationPlayer.play("idle")
