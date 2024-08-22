extends RigidBody2D


@export var radius: int
@export var distance: RayCast2D
@export var strength = 750

var thrown = false
var retracted = true
var player


func _ready():
	player = $"../Player"
	#distance.set_collision_mask(16)

func _process(delta):
	
	print(position)
	if !thrown:
		self.position = player.position
		
		if Input.is_action_just_pressed("grapple"):
			var direction = get_global_mouse_position() - transform.origin
			var impulse_direction = direction.normalized()
			throw_grapple(strength, impulse_direction)
			print(impulse_direction)
	elif thrown:
		#distance.target_position = player.position
		if self.position.distance_to(player.position) > 500:
			self.linear_velocity = Vector2.ZERO
		if Input.is_key_pressed(KEY_R):
			thrown = false
	


func _physics_process(_delta):
	pass
	
	
func throw_grapple(throw_strength, direction):
	thrown = true
	self.apply_central_impulse(direction * throw_strength)
