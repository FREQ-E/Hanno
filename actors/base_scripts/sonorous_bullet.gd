class_name SonorousBullet
extends BaseBullet


export(Array, AudioStream) var sounds: Array
export var extra_db := 0.0


func _handle_collision(body: Node) -> void:
	queue_free()
	
	if body.is_in_group(target_group):
		body.health_component.health -= damage
	
		var sound_player := AudioStreamPlayer2D.new()
		sound_player.transform = transform
		sound_player.stream = sounds[round(rand_range(0, sounds.size() - 1))]
		sound_player.autoplay = true
		# warning-ignore:return_value_discarded
		sound_player.connect("finished", sound_player, "queue_free")
		sound_player.volume_db = extra_db
		get_parent().add_child(sound_player)
