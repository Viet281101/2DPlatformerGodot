extends Area2D

const SPEED = 100

#var ACCELERATION = 400
#var MAX_SPEED = 100

var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var velocity = Vector2()
var Player = null
var speed = 3
var direction = 1


func _ready():
#	look_vec = Player.position - global_position
	pass

func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	

func _physics_process(delta):
	move = Vector2.ZERO
	
#	if Player != null:
#		move = position.direction_to(Player.position) * 3
#	else:
#		move = Vector2.ZERO
	
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("Animate")
	
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed
	position += move
	
#	var player = $Area2D.player
#	if player != null:
#		var direction = (player.global_position - global_position).normalized()
#		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
