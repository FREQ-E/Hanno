class_name SpawnInstance
extends VisibilityNotifier2D


export var distance_check := true
export var max_distance := 5000.0
export var spawn_check := true
export var auto_area := true

var player: Node2D


func _ready():
	set_process(false)
	if spawn_check and get_parent().owner == null:
		get_parent().hide()
		var area: Area2D
		
		if auto_area:
			area = Area2D.new()
			var shape_node := CollisionShape2D.new()
			var shape := RectangleShape2D.new()
			
			shape.extents = rect.size / 2
			shape_node.shape = shape
			shape_node.transform.origin = rect.position + shape.extents
			area.add_child(shape_node)
			add_child(area)
		
		else:
			area = $Area
		
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		
		if is_on_screen() or not area.get_overlapping_bodies().empty():
			get_parent().queue_free()
			return
		
		get_parent().show()
	
	if distance_check:
		player = GlobalFuncs.yield_and_get_group("Player")[0]
		# waring-ignore-all:return_value_discarded
		connect("screen_exited", self, "set_process", [true])
		connect("screen_entered", self, "set_process", [false])


func _process(_delta):
	if global_transform.origin.distance_to(player.global_transform.origin) >= max_distance:
		get_parent().queue_free()
