class_name Player extends CharacterBody3D

@export var camera_smoothness = 0.1

@onready var camera = $CameraTarget/Camera3D
@onready var camera_target = $CameraTarget
@onready var anim_tree = $AnimationTree
@onready var char_model = $player_animated

const SPEED = 2.5
const JUMP_VELOCITY = 2.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, SPEED / 10.0)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, SPEED / 10.0)
		
		# Handle rotation
		char_model.rotation.y= lerp_angle(char_model.rotation.y,atan2(-velocity.x,-velocity.z), 0.25)
		#char_model.look_at(global_position + direction)
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Set animation
	anim_tree.set("parameters/Walk/blend_amount", velocity.normalized().length())
	
	var camera_offset: Vector3 = abs(camera.position - camera_target.global_position)
	if not camera_offset.is_zero_approx():
		camera.position = 	lerp(camera.position, camera_target.global_position, camera_smoothness)
