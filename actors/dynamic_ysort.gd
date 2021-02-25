class_name DynamicYSort
extends VisibilityNotifier2D


func _ready():
	set_process(false)
	# warning-ignore-all:return_value_discarded
	connect("screen_entered", self, "set_process", [true])
	connect("screen_exited", self, "set_process", [false])


func _process(_delta):
	get_parent().z_index = int(clamp(get_viewport_transform().xform(get_parent().global_transform.origin).y, 0, INF))
