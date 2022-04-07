extends Spatial

var mouse_delta = Vector2.ZERO

onready var mouse_sensitivity = get_parent().mouse_sensitivity
onready var mouse_captured = true

func _ready():
	Events.connect("mouse_hidden", self, "mouse_hidden")
	Events.connect("mouse_showed", self, "mouse_showed")

func _unhandled_input(event):
	if not mouse_captured:
		return

	if event is InputEventMouseMotion:
		mouse_delta = event.relative

func _process(delta):
	if not mouse_captured:
		return

	var rot = Vector3(mouse_delta.y, mouse_delta.x, 0) * mouse_sensitivity * delta

	self.rotation.x += rot.x
	self.rotation.y -= rot.y

	mouse_delta = Vector2.ZERO

func mouse_showed():
	mouse_captured = false

func mouse_hidden():
	mouse_captured = true
