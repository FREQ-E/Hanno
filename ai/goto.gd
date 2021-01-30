# A pathfinder which controls the parent to reach the target_origin
class_name Goto
extends Node


signal finished

export var navigation_path: NodePath = "GlobalNavigation"
export var speed := 1000.0
export var enabled := false setget set_enabled
export var one_shot := true									# if true, will disable once the target is reached
export(float, 0, 1) var halting_tolerance := 0.01

var navigation: Node
var target_origin
var movement_vector
var was_on_wall := false
var path

var _is_ready := false

onready var _last_origin = get_parent().global_transform.origin


func _ready():
	_is_ready = true
	
	if navigation_path == NodePath("GlobalNavigation"):
		if not is_instance_valid(GlobalData.navigation):
			yield(GlobalData, "navigation_changed")
	
		navigation = GlobalData.navigation
	
	else:
		navigation = get_node(navigation_path)


func set_enabled(value: bool) -> void:
	enabled = value
	
	if not _is_ready:
		yield(self, "ready")
	
	if not value:
		get_parent().movement_vector *= 0
	
	set_process(value)


func _process(_delta):
	if not is_instance_valid(navigation) or target_origin == null:
		return
	
	path = navigation.get_simple_path(navigation.get_closest_point(get_parent().global_transform.origin), navigation.get_closest_point(target_origin))
	if get_parent().is_on_wall():
		if not was_on_wall:
			movement_vector = (path[1] - path[0]).slide(get_parent().get_slide_collision(0).normal).normalized() * speed
		
		was_on_wall = true
		
	else:
		was_on_wall = false
		movement_vector = (path[1] - path[0]).normalized() * speed
	
	get_parent().movement_vector = movement_vector
	
	if one_shot:
		print(path[0].distance_to(_last_origin))
		if path.size() == 2 and ((_last_origin - path[1]).normalized().dot((path[0] - path[1]).normalized()) <= 0 or \
		path[0].distance_to(_last_origin) <= halting_tolerance):
			set_enabled(false)
			emit_signal("finished")
		
		else:
			_last_origin = path[0]
