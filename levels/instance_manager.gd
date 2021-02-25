class_name InstanceManager
extends Node2D


signal can_respawn
signal respawning

export(Array, String, FILE, "*.tscn") var preload_scene_path: Array
export var respawn_free_distance := 3000.0

var cached_scenes: Dictionary

var _respawns_queued := false
var _can_respawn := false

onready var player: Node2D = GlobalFuncs.yield_and_get_group("Player")[0]


func _ready():
	for path in preload_scene_path:
		cached_scenes[path] = load(path)


func _process(_delta):
	if global_transform.origin.distance_to(player.global_transform.origin) <= respawn_free_distance:
		if _respawns_queued:
			emit_signal("respawning")
			_can_respawn = false
			_respawns_queued = false
	
	elif not _can_respawn:
		emit_signal("can_respawn")
		
		for child in get_children():
			child.queue_free()
		
		_can_respawn = true


func queue_respawn(instance: Node) -> void:
	var new_scene: Node = cached_scenes[instance.get_parent().filename].instance()
	new_scene.transform = instance.original_transform
	
	if not _can_respawn:
		yield(self, "can_respawn")
	
	_respawns_queued = true
	yield(self, "respawning")
	add_child(new_scene)
