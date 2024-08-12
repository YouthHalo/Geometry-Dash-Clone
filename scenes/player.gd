extends CharacterBody2D


const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var speed = $"..".PLAYERSPEED

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		$Sprite2D.modulate = Color(0,1,0)
		velocity.y += gravity * delta
		rotate(deg_to_rad(4))
	if is_on_floor():
		$Sprite2D.modulate = Color(1,1,1)
		#rotation = deg_to_rad(0)

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	velocity.x = speed
	if is_on_wall():
		queue_free()
	move_and_slide()
