extends  CharacterBody2D

class_name Bird

signal game_started

@export var gravity = 900.0
@export var jump_force = -300.0
@export var rotation_speed = 2
@onready var animation_player = $AnimationPlayer

var max_speed = 400.0
var is_Started = false
var game_over = false
 
func ready():
	velocity = Vector2.ZERO
	animation_player.play("idle")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("jump") && !game_over:
		if !is_Started:
			game_started.emit()
			animation_player.play("flap_wings")
			is_Started = true
		jump()
	
	if !is_Started:
		return
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, max_speed)
	
	move_and_collide(velocity * delta)
	
	rotate_bird()
	
func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)
	
func rotate_bird():
	#Rotate downwards while falling
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	#Rotate upward while raising
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)

func kill():
	game_over = true 

func stop():
	animation_player.stop()
	velocity = Vector2.ZERO
	gravity = 0
	rotation_speed = 0
