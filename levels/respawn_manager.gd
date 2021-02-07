class_name RespawnManager
extends Node


var respawn_filenames: Array
var respawn_transforms: Array
var respawn_distances: PoolRealArray

var cached_scenes: Dictionary

onready var player: Node = GlobalFuncs.yield_and_get_group("Player")[0]


func track_respawn_target(flag: RespawnFlag) -> void:
	var parent := flag.get_parent()
	var tmp_transform = parent.global_transform
	yield(parent, "tree_exited")
	respawn_transforms.append(tmp_transform)
	var path := parent.filename
	
	if not path in cached_scenes:
		cached_scenes[path] = load(path)
	
	respawn_filenames.append(path)
	respawn_distances.append(flag.distance)


func _process(_delta):
	var player_origin = player.global_transform.origin
	var handled: PoolIntArray
	
	for i in range(respawn_filenames.size()):
		var tmp_transform = respawn_transforms[i]
		
		if player_origin.distance_to(tmp_transform.origin) <= respawn_distances[i]:
			handled.append(i)
			var instance: Node = cached_scenes[respawn_filenames[i]].instance()
			add_child(instance)
			instance.global_transform = tmp_transform
	
	for i in handled:
		respawn_filenames.remove(i)
		respawn_transforms.remove(i)
		respawn_distances.remove(i)
