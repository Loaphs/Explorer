extends RigidBody2D


@export var radius: int
@export var distance: RayCast2D
@export var grapple_length = 500

var player


func _ready():
	player = $"../Player"
	position = player.position
	gravity_scale = 0
	#distance.set_collision_mask(16)

func _process(_delta):
	#distance.target_position = player.position
	if self.position.distance_to(player.position) > grapple_length:
		player.reload()

func _physics_process(delta):
	pass
	
func _integrate_forces(state):
	if player.loaded:
		var t = state.get_transform()
		t.origin.x = player.transform.origin.x
		t.origin.y = player.transform.origin.y
		state.set_transform(t)
	
	
func throw_grapple(throw_strength):
	var direction = get_global_mouse_position() - global_position
	var impulse_direction = direction.normalized()
	gravity_scale = 1
	self.apply_central_force(impulse_direction * throw_strength)
	

func _on_body_entered(body):
	print("collided")
	freeze = true
