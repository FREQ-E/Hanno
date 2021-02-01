# A raycast node which constantly tries to cast to the target
class_name NodeSight2D
extends RayCast2D


signal triggered			# emitted as soon as the target is hit and in range
signal untriggered			# emitted as soon as the target falls out of sight/range

export var target_path: NodePath = "player"		# the path to the target (leave at "player" to target the player group)
export var max_distance := 3000.0				# the maximum distance the raycast will cast to

var target: Node2D							# the node this raycast will cast to
var target_visible := false					# true if the target node is in range and in sight


func _ready():
	if target_path == NodePath("player"):
		target = GlobalFuncs.yield_and_get_group("player")[0]
	
	elif not target_path.is_empty():
		target = get_node(target_path)


func get_collision_vector() -> Vector2:
	return get_collision_point() - global_transform.origin


func _process(_delta):
	if is_instance_valid(target):
		if get_collider() == target:
			if not target_visible:
				emit_signal("triggered")
			
			target_visible = true
		
		else:
			if target_visible:
				emit_signal("untriggered")
			
			target_visible = false
		
		if max_distance == 0:
			cast_to = to_local(target.global_transform.origin).clamped(max_distance)
		
		else:
			cast_to = to_local(target.global_transform.origin)
	
	else:
		if target_visible:
			emit_signal("untriggered")
		
		target_visible = false
