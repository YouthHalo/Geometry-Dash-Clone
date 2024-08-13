extends CharacterBody2D


const JUMP_VELOCITY = -350.0

@onready var speed = $"..".PLAYERSPEED
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling = true
var airjump = false

func _ready():
	velocity.x = speed
	self.visible = true
	
	
func movement(delta):
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
	
	if Input.is_action_just_pressed("jump") and airjump:
		velocity.y = JUMP_VELOCITY
		falling = true
		airjump = false
	if is_on_wall():
		velocity = Vector2(0,0)
		$Sprite2D.hide()
		$GPUParticles2D.show()
		$GPUParticles2D.emitting = true


func _physics_process(delta):
	movement(delta)
	move_and_slide()


func _on_orb_body_entered(body):
	airjump = true


func _on_orb_body_exited(body):
	airjump = false
