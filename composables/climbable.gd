extends Spatial

onready var rays = get_children()
onready var head_ray = $Head
onready var chest_ray = $Chest

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func can_climb() -> bool:
	if not head_ray.is_colliding():
		return false

	if not chest_ray.is_colliding():
		return false

	return true

func get_chest_collision_normal() -> Vector3:
	return chest_ray.get_collision_normal()

func get_chest_collider():
	return chest_ray.get_collider()

func get_chest_collision_point():
	return chest_ray.get_collision_point()

func get_chest_origin_global():
	return chest_ray.global_transform.origin

func get_chest_origin_local():
	return chest_ray.transform.origin

func can_step_over() -> bool:
	if head_ray.is_colliding():
		return false

	if not chest_ray.is_colliding():
		return false

	return true

func get_chest_local_origin() -> Vector3:
	return chest_ray.transform.origin

func get_chest_dir() -> Vector3:
	return chest_ray.cast_to - chest_ray.transform.origin

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
