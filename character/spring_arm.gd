extends SpringArm

onready var player = get_parent().get_parent()

func _ready():
	self.add_excluded_object(player)

