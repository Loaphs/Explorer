extends CharacterBody2D


var grappleObj
var grapple
var throw_strength = 45000
var loaded = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var faceRight = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var landing : bool

#@onready var anim = get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	grappleObj = preload("res://Scenes/Gameplay/grapple.tscn")

func _process(_delta):
	# Controls Grapple functions, like throwing and retracting.
	if Input.is_action_just_pressed("reload") && !loaded:
		reload()
	if Input.is_action_just_pressed("grapple") && loaded:
		loaded = false
		grapple.throw_grapple(throw_strength)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
	# Handle Jump.
		velocity.y = JUMP_VELOCITY
		#anim.play("JumpStart")
		
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		#get_node("AnimatedSprite2D").flip_h = true
		faceRight = -1
	elif direction == 1:
		#get_node("AnimatedSprite2D").flip_h = false
		faceRight = 1
		
	if direction:
		velocity.x = direction * SPEED
		#if velocity.y == 0:
			#anim.play("Run")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#if velocity.y == 0:
			#anim.play("Idle")
			
	#if not is_on_floor() and velocity.y > 0:
		#anim.play("Fall")

	move_and_slide()

# Instantiate new grapple hook, deleting old one.
func reload():
	if grapple:
		grapple.queue_free()
	grapple = grappleObj.instantiate()
	get_parent().add_child(grapple)
	loaded = true
