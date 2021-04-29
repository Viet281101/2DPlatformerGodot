extends KinematicBody2D


const Effect = preload("res://Scenes/Effects.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

enum{
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var move = Vector2.ZERO
var speed = 1
var Player = null

onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone

func _ready():
	pass

func _physics_process(delta):
	move = Vector2.ZERO
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	$AnimationPlayer.play("idle")
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
	
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Hurt_area_entered(area):
	stats.health -= 1
	knockback = Vector2.RIGHT * 120

func _on_Stats_no_health():
	queue_free()
	var enenmyDeathEffect = Effect.instance()
	get_parent().add_child(enenmyDeathEffect)
	enenmyDeathEffect.global_position = global_position



