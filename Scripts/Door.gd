extends Area2D


func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene("res://Level 2.tscn")


func _on_Lever_is_active():
	$AnimationPlayer.play("openning")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("opened")
