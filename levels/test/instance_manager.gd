class_name InstanceManager
extends Node


export(Array, String, FILE, "*.tscn") var preload_scene_path: Array

var cached_scenes: Dictionary

onready var player: Node = GlobalFuncs.yield_and_get_group("Player")[0]


func _ready():
	for path in preload_scene_path:
		cached_scenes[path] = load(path)


func hold(instance: Node) -> void:
	remove_child(instance.get_parent())
	var tree := get_tree()
	print(instance.get_parent().name)
	
	while true:
		yield(tree, "idle_frame")
		
		if instance.original_transform.origin.distance_to(player.global_transform.origin) >= instance.min_distance:
			add_child(instance.get_parent())
			return


func respawn_parent(instance: Node) -> void:
	var new_scene: Node = cached_scenes[instance.get_parent().filename].instance()
	var max_distance: float = instance.max_distance
	var original_transform = instance.original_transform
	new_scene.transform = instance.original_transform
	var tree := get_tree()
	
	while true:
		yield(tree, "idle_frame")
		
		if original_transform.origin.distance_to(player.global_transform.origin) < max_distance:
			add_child(new_scene)
			return
