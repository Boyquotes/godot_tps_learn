extends CharacterState

var prev_jump_button_released = true

func activated(_message := {}) -> void:
	if _message.has("fallen"):
		prev_jump_button_released = false

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if Input.is_action_just_released("jump"):
		prev_jump_button_released = true

	if not character.is_on_floor():
		state_machine.travel("Air")
		return

	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		input_dir.z += 1
	if Input.is_action_pressed("move_backward"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_left"):
		input_dir.x += 1
	if Input.is_action_pressed("move_right"):
		input_dir.x -= 1

	if not is_equal_approx(input_dir.length_squared(), 0.0):
		var player_heading_dir = character.rotation_helper.transform.basis.z
		var desired_dir = _get_desired_direction(input_dir)
		var desired_heading_2d = Vector2(desired_dir.x, desired_dir.z)

		var player_heading_2d = Vector2(player_heading_dir.x, player_heading_dir.z)

		var phi = desired_heading_2d.angle_to(player_heading_2d)

		if abs(phi) <= deg2rad(30) and character.climber.can_climb():
			character.rotate_character_y(phi)
			state_machine.travel("Climb")
			return

		var tuned_phi = phi * _delta * character.turn_speed

		character.rotate_character_y(tuned_phi)

		character.velocity.x = desired_dir.x * character.walk_speed
		character.velocity.z = desired_dir.z * character.walk_speed
	else:
		state_machine.travel("Idle")
		return
	
	

	character.velocity += character.falling_gravity * _delta
	character.velocity = character.move_and_slide(character.velocity, Vector3.UP)

	if Input.is_action_pressed("jump") and character.is_on_floor() and prev_jump_button_released:
		state_machine.travel("Air", { "do_jump": true })

func deactivated() -> void:
	prev_jump_button_released = true
