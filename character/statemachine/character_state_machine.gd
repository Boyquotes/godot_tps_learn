class_name CharacterStateMachine
extends Node

signal character_state_transitioned(state_name)

export(NodePath) var intial_state
onready var current_state: CharacterState = get_node(intial_state)

func _ready():
	yield(owner, "ready")
	for child in get_children():
		child.state_machine = self
	current_state.activated()

func _unhandled_input(event):
	current_state.handle_input(event)

func _process(delta):
	current_state.update(delta)

func _physics_process(delta):
	current_state.physics_update(delta)

func travel(target_state_name: String, message: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return

	current_state.deactivated()

	current_state = get_node(target_state_name)
	current_state.activated(message)
	emit_signal("character_state_transitioned", target_state_name)
	print("state change to ", target_state_name)
