extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("show_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Events.emit_signal("mouse_showed")
	elif event.is_action_released("show_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Events.emit_signal("mouse_hidden")
