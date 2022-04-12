extends CharacterState

var chest_collision_normal = Vector3.ZERO

func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	if not character.climber.can_climb():
		state_machine.travel("Air")
		return

	if Input.is_action_pressed("cancel_climb"):
		state_machine.travel("Air")
		return

	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		input_dir.y += 1
	if Input.is_action_pressed("move_backward"):
		input_dir.y -= 1
	if Input.is_action_pressed("move_left"):
		input_dir.x += 1
	if Input.is_action_pressed("move_right"):
		input_dir.x -= 1

	var desired_dir = input_dir.rotated(Vector3.UP, character.rotation_helper.rotation.y).normalized()

	character.velocity = desired_dir * character.climb_speed
	var normal = character.climber.get_chest_collision_normal()
	character.velocity = character.move_and_slide(character.velocity, normal)


func activated(_message := {}) -> void:
	if chest_collision_normal == Vector3.ZERO:
		chest_collision_normal = character.climber.get_chest_collision_normal()
	print(chest_collision_normal)
	var axis_z = -1 * chest_collision_normal
	var axis_x = chest_collision_normal.cross(Vector3.UP).normalized()
	var axis_y = axis_z.rotated(axis_x, -PI/2)

	character.rotation_helper.transform.basis = Basis(axis_x, axis_y, axis_z)


func deactivated() -> void:
	var axis_z = -1 * chest_collision_normal
	axis_z.y = 0
	axis_z = axis_z.normalized()
	var axis_y = Vector3.UP
	var axis_x = axis_z.cross(Vector3.UP).normalized()
	character.rotation_helper.transform.basis = Basis(axis_x, axis_y, axis_z)

	chest_collision_normal = Vector3.ZERO
