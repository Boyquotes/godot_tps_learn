extends CharacterState

var prev_jump_button_released = false

func activated(_message := {}) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	if Input.is_action_just_released("jump"):
		prev_jump_button_released = true

	if Input.is_action_just_pressed("jump") and prev_jump_button_released:
		state_machine.travel("Air")
		return
	
	if character.is_on_floor():
		if is_equal_approx(character.velocity.length_squared(), 0.0):
			state_machine.travel("Idle", { "fallen": true })
		else:
			state_machine.travel("Walk", { "fallen": true })
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

	var player_heading_dir = character.meshes.transform.basis.z
	var desired_dir = _get_desired_direction(input_dir)
	var desired_heading_2d = Vector2(desired_dir.x, desired_dir.z)

	var player_heading_2d = Vector2(player_heading_dir.x, player_heading_dir.z)

	var phi = desired_heading_2d.angle_to(player_heading_2d)
	var tuned_phi = phi * _delta * character.turn_speed * character.air_friction_rate

	character.meshes.rotation.y += tuned_phi

	character.velocity.x = desired_dir.x * character.glide_speed
	character.velocity.z = desired_dir.z * character.glide_speed

	character.velocity += character.falling_gravity * _delta * character.air_friction_rate
	character.velocity = character.move_and_slide(character.velocity, Vector3.UP)

	
func deactivated() -> void:
	prev_jump_button_released = false
	pass
