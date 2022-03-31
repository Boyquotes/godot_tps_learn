class_name Character
extends KinematicBody

export var mouse_sensitivity: float = 0.5
export var walk_speed: float = 10
export var run_speed: float = 20
export var sprint_speed: float = 30
export var turn_speed: float = 10
export var falling_gravity = Vector3(0, -15.0, 0)
export var jump_speed: float = 7
export var air_friction_rate : float = 0.3
export var glide_speed: float = 6

export(NodePath) onready var meshes = get_node(meshes)
export(NodePath) onready var camera_orbit = get_node(camera_orbit)

var velocity = Vector3.ZERO
var gravity = Vector3.ZERO

var prev_jump_button_released = true
