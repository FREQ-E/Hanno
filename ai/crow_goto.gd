# A goto which goes straight for the target
class_name CrowGoto
extends Node


signal finished

export var speed := 1000.0
export var enabled := false setget set_enabled
export var one_shot := true									# if true, will disable once the target is reached

var target_origin
var movement_vector
var was_on_wall := false
var path := [null, null]

var _is_ready := false

onready var _last_origin = get_parent().global_transform.origin


func set_enabled(value: bool) -> void:
	enabled = value
	
	if not _is_ready:
		yield(self, "ready")
	
	if not value:
		get_parent().movement_vector *= 0
	
	set_process(value)


func _ready():
	_is_ready = true


func _process(_delta):
	if target_origin == null:
		return
	
	path[0] = get_parent().global_transform.origin
	path[1] = target_origin
	if get_parent().is_on_wall():
		if not was_on_wall:
			movement_vector = (path[1] - path[0]).slide(get_parent().get_slide_collision(0).normal).normalized() * speed
		
		was_on_wall = true
		
	else:
		was_on_wall = false
		movement_vector = (path[1] - path[0]).normalized() * speed
	
	get_parent().movement_vector = movement_vector
	
	if one_shot:
		if path.size() == 2 and (_last_origin - path[1]).normalized().dot((path[0] - path[1]).normalized()) <= 0:
			set_enabled(false)
			emit_signal("finished")
		
		else:
			_last_origin = path[0]
