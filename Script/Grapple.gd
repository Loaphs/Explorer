extends RigidBody2D


@export var radius: int
@export var distance: int
@export var strength = 50

var thrown = false
var player


func _ready():
	player = $"../Player"

func _process(delta):
	
	if !thrown:
		self.position = player.position
		
		if Input.is_action_just_pressed("grapple"):
			
			var direction = get_global_mouse_position() - transform.origin
			var impulse_direction = direction.normalized()
			throw_grapple(strength, impulse_direction)
			print(direction)
	else:
		if Input.is_key_pressed(KEY_R):
			thrown = false	
	


func _physics_process(delta):
	pass
	
	
func throw_grapple(throw_strength, direction):
	thrown = true
	self.apply_central_force(direction)
