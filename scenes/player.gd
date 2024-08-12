extends CharacterBody2D


const JUMP_VELOCITY = -350.0

@onready var speed = $"..".PLAYERSPEED
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling = true
func _ready():
	velocity.x = speed
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		$Sprite2D.modulate = Color(0,1,0)
		velocity.y += gravity * delta
	if falling:
		rotate(deg_to_rad(4))
	if is_on_floor():
		falling = false
		$Sprite2D.modulate = Color(1,1,1)
		rotation_degrees = round(rotation_degrees / 90) *90

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		falling = true

	if is_on_wall():
		queue_free()
	move_and_slide()
