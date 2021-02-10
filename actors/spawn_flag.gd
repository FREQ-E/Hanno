class_name SpawnFlag
extends Node


export var area_path: NodePath
export var respawn := true

onready var instance_manager: InstanceManager = get_parent().get_parent()
onready var original_transform = get_parent().transform


func _ready():
	if get_parent().owner == null:
		get_parent().hide()
		
		yield(get_tree(), "physics_frame")
		
		if not area_path.is_empty() and get_node(area_path).get_overlapping_bodies().empty():
			get_parent().queue_free()
			return
		
		get_parent().show()


func _exit_tree():
	instance_manager.queue_respawn(self)
