class_name RandomTileMap
extends TileMap


export var max_size := Vector2(16, 16)		# the max number of cells in each axis
export var thresholds: PoolRealArray


func _ready():
	for idx in range(get_child_count()):
		var noise: OpenSimplexNoise = get_child(idx).texture.noise
		noise.seed = GlobalFuncs.rng.randi()

		for x in range(int(max_size.x)):
			for y in range(int(max_size.y)):
				var real_coords := map_to_world(Vector2(x, y)) * scale
				
				if noise.get_noise_2d(real_coords.x, real_coords.y) >= thresholds[idx]:
					set_cell(x, y, idx)
	
