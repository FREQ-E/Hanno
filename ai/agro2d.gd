# Chases the target, while remaining min_distance away
class_name Agro2D
extends State


export var min_distance := 100.0
export var speed := 300.0
export var notice_sub_targets := true


func _ready():
	yield(get_parent(), "ready")


func _loop() -> void:
	var parent_target: Node = get_parent().trigger_node.target
	var use_sub_targets := notice_sub_targets and parent_target.has_node("Targets")
	var target: Node
	
	if not use_sub_targets:
		target = parent_target
	
	get_parent().goto.one_shot = false
	get_parent().goto.speed = speed
	# warning-ignore:return_value_discarded
	get_tree().connect("idle_frame", self, "continue_loop")
	
	while active:
		if use_sub_targets:
			var targets := parent_target.get_node("Targets").get_children()
			var min_distance := INF
			var current_origin: Vector2 = get_parent().get_parent().global_transform.origin
			
			for t in targets:
				var distance := current_origin.distance_to(t.global_transform.origin)
				if distance < min_distance:
					target = t
					min_distance = distance
		
		get_parent().goto.target_origin = target.global_transform.origin
		yield(self, "_continue_loop")
		
		if not active:
			break
		
		if get_parent().goto.enabled:
			var path = get_parent().goto.path
			get_parent().goto.enabled = not (path.size() == 2 and path[0].distance_to(path[1]) <= min_distance)
		
		else:
			get_parent().goto.enabled = get_parent().get_parent().global_transform.origin.distance_to(target.global_transform.origin) > min_distance
	
	get_parent().goto.enabled = false
	get_tree().disconnect("idle_frame", self, "continue_loop")
	emit_signal("loop_finished")

