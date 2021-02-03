class_name SpawnChecker
extends VisibilityNotifier2D


var spawn_check := false			# set by the spawner, if true, will queue_free if was on screen when spawning


func _ready():
	if spawn_check:
		get_parent().hide()
		var area := Area2D.new()
		var shape_node := CollisionShape2D.new()
		var shape := RectangleShape2D.new()
		
		shape.extents = rect.size / 2
		shape_node.shape = shape
		shape_node.transform.origin = rect.position + shape.extents
		area.add_child(shape_node)
		add_child(area)
		
		yield(get_tree(), "idle_frame")
		
		if is_on_screen() or not area.get_overlapping_bodies().empty():
			get_parent().queue_free()
		
		else:
			queue_free()
			get_parent().show()
	
	else:
		queue_free()
