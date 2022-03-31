extends CharacterState

func activated(_message := {}) -> void:
	character.velocity = Vector3.ZERO

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	character.velocity += character.falling_gravity * _delta
	character.velocity = character.move_and_slide(character.velocity, Vector3.UP)

	if not character.is_on_floor():
		state_machine.travel("Air")
		return

	if Input.is_action_pressed("jump") and character.is_on_floor():
		state_machine.travel("Air", { "do_jump": true })
		return
	elif Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_backward") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.travel("Walk")
		return

func deactivated() -> void:
	pass
