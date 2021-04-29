extends Area2D

export(bool) var show_hit = true

const HitEffect = preload("res://Scenes/HitEffect.tscn")

var invincible = false setget set_invincible

onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func _ready():
	pass

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func _on_Timer_timeout():
	self.invincible = false


func _on_Hurt_invincibility_started():
	monitorable = false


func _on_Hurt_invincibility_ended():
	monitorable = true


func _on_Hurt_area_entered(area):
	if show_hit:
		var effect = HitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(effect)
		effect.global_position = global_position
		effect.stop(effect)
		

