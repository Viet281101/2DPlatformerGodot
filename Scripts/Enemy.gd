extends KinematicBody2D

const Effect = preload("res://Scenes/Effects.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

#########################
onready var BULLET_SCENE = preload("res://Scenes/Bullet.tscn")
onready var BULLET_SCENE2 = preload("res://Scenes/Bullet2.tscn")
########################

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
	#####################################3
	if Player != null:
		move = position.direction_to(Player.position) * speed
		
	else:
		move = Vector2.ZERO
	move = move.normalized()
	move = move_and_collide(move)
	#####################################
	
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
	$AnimationPlayer.play("hurt")

func _on_Stats_no_health():
	queue_free()
	var enenmyDeathEffect = Effect.instance()
	get_parent().add_child(enenmyDeathEffect)
	enenmyDeathEffect.global_position = global_position


####################################################
func _on_DetectionPlayerToFire_body_entered(body):
	if body != self:
		Player = body


func _on_DetectionPlayerToFire_body_exited(body):
	body = null
###################################################

func _on_Timer_timeout():
	if Player != null:
		##############
		var bullet = BULLET_SCENE.instance()
		if sign($Position2D.position.x) == 1:
			bullet.set_bullet_direction(1)
		else:
			bullet.set_bullet_direction(-1)
		get_parent().add_child(bullet)
		bullet.position = $Position2D.global_position
		
		var bullet2 = BULLET_SCENE2.instance()
		if sign($Position2D.position.x) == 1:
			bullet2.set_bullet_direction(1)
		else:
			bullet2.set_bullet_direction(-1)
		get_parent().add_child(bullet2)
		bullet2.position = $Position2D.global_position
