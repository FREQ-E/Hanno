# Chases the target, while remaining min_distance away
class_name Agro2D
extends State


export var min_distance := 200.0
export var speed := 300.0

var target: Node


func _ready():
	yield(get_parent(), "ready")


func _loop() -> void:
	target = get_parent().trigger_node.target
	get_parent().goto.one_shot = false
	get_parent().goto.speed = speed
	get_tree().connect("idle_frame", self, "continue_loop")
	
	while active:
		get_parent().goto.target_origin = target.global_transform.origin
		yield(self, "_continue_loop")
		
		if not active:
			break
		
		var path = get_parent().goto.path
		
		if get_parent().goto.enabled:
			get_parent().goto.enabled = not (path.size() == 2 and path[0].distance_to(path[1]) <= min_distance)
		
		else:
			get_parent().goto.enabled = get_parent().get_parent().global_transform.origin.distance_to(target.global_transform.origin) > min_distance
	
	get_parent().goto.enabled = false
	get_tree().disconnect("idle_frame", self, "continue_loop")
	emit_signal("loop_finished")

