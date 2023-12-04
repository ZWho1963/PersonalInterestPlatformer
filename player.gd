extends CharacterBody2D
class_name Player

@export var SPEED = 250.0
@export var ACCELERATION = 1500.0
@export var FRICTION = 1500.0
@export var JUMP_VELOCITY = -550.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity = 980


func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)

	move_and_slide()
	
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
			
func handle_jump():
	if velocity.y == 0 and is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
		
func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)

