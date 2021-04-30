extends KinematicBody2D

export var speed = 500
export var gravity = 380
export var jump = 300
export var spring = 500

var holywell = 900
var bloodwell = 900
var friction = 0.5
var max_speed = 150
var velocity = Vector2.ZERO
var resistance = 0.7
var jumpNumber = 2
var canPick = true
var on_ground = false
var wallJump = 150
var jumpWall = 60
var jumpCount = 0
var stats = PlayerStats

export var extraJumps = 1
export var jumpForce = -300

const FIREBALL = preload("res://Scenes/Fireball.tscn")
const FIREBALL2 = preload("res://Scenes/Fireball2.tscn")

enum{
	MOVE,
	ATTACK
}
var state = MOVE

onready var sprite = $Sprite
onready var ani = $AnimationPlayer
onready var hit = $HitPivot/Hit

func _ready():
	stats.connect("no_health", self, "queue_free")

func _physics_process(delta):
	#####Fireball:
	if Input.is_action_just_pressed("ui_focus_next"):
		var fireball = FIREBALL.instance()
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
		AttackSound.play_sound()
		
	if Input.is_action_just_pressed("ui_focus_prev"):
		#To treat HP:)
		#PlayerStats.max_health += 1
		var fireball2 = FIREBALL2.instance()
		if sign($Position2D.position.x) == 1:
			fireball2.set_fireball2_direction(1)
		else:
			fireball2.set_fireball2_direction(-1)
		get_parent().add_child(fireball2)
		fireball2.position = $Position2D.global_position
		AttackSound.play_sound()
	
	########JumpForce:
	if Input.is_action_just_pressed("ui_jump_force") && jumpCount < extraJumps:
		velocity.y = jumpForce
		jumpCount += 1
	
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
	
func move_state(delta):
	var movement_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if movement_x != 0:
		ani.play("run")
		velocity.x += movement_x * speed * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
		sprite.flip_h = movement_x < 0
	
	if is_on_floor() or nextToWall():
		jumpNumber = 2
		jumpCount = 0
		if Input.is_action_just_pressed("ui_accept") and jumpNumber > 0:
			velocity.y -= jump
			jumpNumber -= 1
			ani.play("jump")
			if not is_on_floor() and nextToRightWall():
				velocity.x -= wallJump
				velocity.y -= jumpWall
			if not is_on_floor() and nextToLeftWall():
				velocity.x += wallJump
				velocity.y -= jumpWall
		
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, friction)
			ani.play("idle")
			velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
		if Input.is_action_just_pressed("ui_up"):
			velocity.y -= jump
			ani.play("jump")
			Swipe.play_sound()
		else:
			if movement_x == 0:
				ani.play("fall")
				velocity.x = lerp(velocity.x, 0, resistance)


	velocity.y += gravity * delta
	velocity =  move_and_slide(velocity, Vector2.UP)
	
	#####Attack:
	if Input.is_action_just_pressed("ui_attack"):
		state = ATTACK

func nextToWall():
	return nextToRightWall() or nextToLeftWall()

func nextToRightWall():
	return $rightWall.is_colliding()

func nextToLeftWall():
	return $leftWall.is_colliding()
	
func attack_state(delta):
	ani.play("attack")

func attack_animation_finished():
	state = MOVE

func _on_Spring_body_entered(body):
	velocity.y -= spring


func _on_item_body_entered(body):
	velocity.y -= holywell


func _on_bloodwell_body_entered(body):
	ani.play("jump")
	velocity.y += bloodwell


func _on_Hurt_area_entered(area):
	HurtSound.play_sound()
	ani.play("hurt")
	stats.health -= 1
	ani.play("hurt")


func _on_Holy_well_of_reborn_body_entered(body):
	stats.health += 1
	stats.max_health += 1


#func _on_Trap_body_entered(body):
#	stats.health -= 1
##	stats.max_health -= 1


func _on_Healer_potion_body_entered(body):
	stats.max_health += 1
	stats.health += 1


func _on_PlayerStats_no_health():
	if PlayerStats.max_health <= 0:
		ani.play("die")
		get_tree().change_scene("res://Scenes/GameOverScreen.tscn")










func _on_Trap_body_entered(body):
	pass # Replace with function body.
