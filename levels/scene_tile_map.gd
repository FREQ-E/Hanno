# A way to instance scenes like a tilemap
class_name SceneTileMap
extends TileMap


# Each scene in this array will replace the corresponding tile
export(Array, PackedScene) var scenes: Array


func _ready():
	for idx in range(scenes.size()):
		var scene: PackedScene = scenes[idx]
		
		for pos in get_used_cells_by_id(idx):
			var instance := scene.instance()
			instance.transform.origin = map_to_world(pos) * scale
			get_parent().call_deferred("add_child", instance)
	
	hide()
