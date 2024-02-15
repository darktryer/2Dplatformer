extends CharacterBody2D

@export var SPEED:float = 200.0
@export var JUMP_VELOCITY:float = -300.0
@export var DOUBLE_JUMP_VELOCITY:float = -450.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var afterJumpIsOnFloorMoment1 = 0
var has_double_jump : bool = false
var is_jump_pressed = [Input.is_action_pressed("jump1"), Input.is_action_pressed("jump2")]
var is_just_jump_pressed = [Input.is_action_just_pressed("jump1"), Input.is_action_just_pressed("jump2")]
var direction = Input.get_vector("left1", "right1", "jump1", "")


func _ready():
	get_viewport().content_scale_factor = 2.4
	animation_tree.active = true
	
func anim_update():
	animation_tree.set("parameters/BlendSpace1D/blend_position", direction.x)
	
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	var afterJumpIsOnFloorMoment2 = 0
	if is_on_floor():
		afterJumpIsOnFloorMoment2 = Time.get_ticks_msec()
		has_double_jump = false
	var noJumpTime = afterJumpIsOnFloorMoment2 - afterJumpIsOnFloorMoment1
	
	if is_jump_pressed[0] or is_jump_pressed[1]:
		if is_on_floor() and noJumpTime > 400:
			velocity.y = JUMP_VELOCITY
		afterJumpIsOnFloorMoment1 = Time.get_ticks_msec()
	elif (is_jump_pressed[0] or is_jump_pressed[1]) and not has_double_jump and not is_on_floor:
		velocity.y = DOUBLE_JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction1 = Input.get_axis("move_left1", "move_right1", "jump1", "move_down1")
	var direction2 = Input.get_axis("move_left2", "move_right2", "jump2", "move_down2")
	if direction1:
		velocity.x = direction1 * SPEED
	elif direction2:
		velocity.x = direction2 * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
