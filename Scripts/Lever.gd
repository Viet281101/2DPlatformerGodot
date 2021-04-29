extends Area2D

signal is_active

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			$AnimationPlayer.play("active")
			yield($AnimationPlayer,"animation_finished")
			$AnimationPlayer.play("idel_active")
			emit_signal("is_active")
		else:
			$AnimationPlayer.play("idle")
