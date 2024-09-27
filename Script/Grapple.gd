extends RigidBody2D


@export var radius: int
@export var distance: RayCast2D
<<<<<<< HEAD
@export var grapple_length = 500
=======
@export var strength = 750
>>>>>>> refs/remotes/origin/kitty

var player


func _ready():
	player = $"../Player"
	position = player.position
	gravity_scale = 0
	#distance.set_collision_mask(16)

<<<<<<< HEAD
func _process(_delta):
	#distance.target_position = player.position
	if self.position.distance_to(player.position) > grapple_length:
		player.reload()
=======
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
	

>>>>>>> refs/remotes/origin/kitty

func _physics_process(_delta):
	pass
	
func _integrate_forces(state):
	if player.loaded:
		var t = state.get_transform()
		t.origin.x = player.transform.origin.x
		t.origin.y = player.transform.origin.y
		state.set_transform(t)
	
<<<<<<< HEAD
	
func throw_grapple(throw_strength):
	var direction = get_global_mouse_position() - global_position
	var impulse_direction = direction.normalized()
	gravity_scale = 1
	self.apply_central_force(impulse_direction * throw_strength)
	

func _on_body_entered(body):
	print("collided")
	freeze = true
=======
func throw_grapple(throw_strength, direction):
	thrown = true
	self.apply_central_impulse(direction * throw_strength)
>>>>>>> refs/remotes/origin/kitty
