class_name SpawnInstance
extends Node


export var min_distance := 3000.0
export var max_distance := 5000.0
export var area_path: NodePath
export var respawn := true

var player: Node
var instance_manager: InstanceManager

var _has_spawned := false

onready var original_transform = get_parent().transform


func _ready():
	if get_parent().owner == null:
		set_process(false)
		get_parent().hide()
		
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		
		if not area_path.is_empty() and get_node(area_path).get_overlapping_bodies().empty():
			get_parent().queue_free()
			return
		
		instance_manager = get_parent().get_parent()
		player = instance_manager.player
		
		if player.global_transform.origin.distance_to(get_parent().global_transform.origin) < min_distance:
			instance_manager.hold(self)
			yield(self, "tree_entered")
		
		get_parent().show()
		set_process(true)
	
	else:
		instance_manager = get_parent().get_parent()
		
		if instance_manager.player == null:
			yield(instance_manager, "ready")
		
		player = instance_manager.player
	
	_has_spawned = true


func _process(_delta):
	if get_parent().global_transform.origin.distance_to(player.global_transform.origin) >= max_distance:
		get_parent().queue_free()


func _exit_tree():
	if _has_spawned and respawn:
		instance_manager.respawn_parent(self)
