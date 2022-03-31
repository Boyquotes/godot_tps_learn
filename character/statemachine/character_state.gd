class_name CharacterState
extends Node

var state_machine = null

var character: Character

func _ready():
	yield(owner, "ready")
	character = owner as Character

	assert(character != null)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func activated(_message := {}) -> void:
	pass

func deactivated() -> void:
	pass
	
func _get_desired_direction(input_dir: Vector3) -> Vector3:
	return input_dir.rotated(Vector3.UP, character.camera_orbit.rotation.y).normalized()
