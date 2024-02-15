extends CharacterBody2D

@export var SPEED:float = 200.0
@export var JUMP_VELOCITY:float = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var afterJumpIsOnFloorMoment1 = 0

func _ready():
	get_viewport().content_scale_factor = 2.4

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	var afterJumpIsOnFloorMoment2 = 0
	if is_on_floor():
		afterJumpIsOnFloorMoment2 = Time.get_ticks_msec()
	var noJumpTime = afterJumpIsOnFloorMoment2 - afterJumpIsOnFloorMoment1
	if (Input.is_action_pressed("jump1") or Input.is_action_pressed("jump2")) and is_on_floor() and noJumpTime > 400:
		velocity.y = JUMP_VELOCITY
		afterJumpIsOnFloorMoment1 = Time.get_ticks_msec()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction1 = Input.get_axis("move_left1", "move_right1")
	var direction2 = Input.get_axis("move_left2", "move_right2")
	if direction1:
		velocity.x = direction1 * SPEED
	elif direction2:
		velocity.x = direction2 * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
