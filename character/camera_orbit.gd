extends Spatial

var mouse_delta = Vector2.ZERO

onready var mouse_sensitivity = get_parent().mouse_sensitivity

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

func _process(delta):
	var rot = Vector3(mouse_delta.y, mouse_delta.x, 0) * mouse_sensitivity * delta

	self.rotation.x += rot.x
	self.rotation.y -= rot.y

	mouse_delta = Vector2.ZERO
