extends CharacterState

const MIN_AIRBORNE_TIME = 0.1

var airborne_time : float = 0
var prev_jump_button_released = false

func activated(_message := {}) -> void:
	if _message.has("do_jump"):
		character.velocity.y += character.jump_speed
		airborne_time = MIN_AIRBORNE_TIME

func handle_input(_event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	if Input.is_action_just_released("jump"):
		prev_jump_button_released = true

	airborne_time += _delta

	character.velocity += character.falling_gravity * _delta

	character.velocity = character.move_and_slide(character.velocity, Vector3.UP)

	if character.is_on_floor():
		if is_equal_approx(character.velocity.length_squared(), 0.0):
			state_machine.travel("Idle", { "fallen": true })
		else:
			state_machine.travel("Walk", { "fallen": true })
		return
	elif Input.is_action_pressed("jump") and prev_jump_button_released:
		state_machine.travel("Glide")
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


func deactivated() -> void:
	airborne_time = 0
	prev_jump_button_released = false
	pass
