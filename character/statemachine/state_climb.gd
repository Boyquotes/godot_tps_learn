extends CharacterState

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
	var normal = character.climber.get_chest_collision_normal()
	var y = Vector3.UP
	var x = normal.cross(y).normalized()
	var basis = Basis(x, y, -1 * normal)
	character.rotation_helper.transform.basis = basis


func deactivated() -> void:
	pass
