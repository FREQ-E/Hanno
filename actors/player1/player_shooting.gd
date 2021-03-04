# A quick node to allow a controllabe Character to shoot
# Must be a direct child of the Character
class_name Shooter
extends Node2D


export var bullet_speed := 1000
export var damage := 0.5
export var fire_rate := 0.2
export(PackedScene) var bullet_scene := preload("res://actors/player1/player_bullet.tscn")
export var sound: AudioStream

var can_fire := true


func shoot(dir: Vector2, buff:=1.0) -> void:
	var bullet_instance = bullet_scene.instance()
	bullet_instance.damage = damage * buff
	bullet_instance.transform = global_transform
	bullet_instance.linear_velocity = dir * bullet_speed
	get_tree().current_scene.add_child(bullet_instance)
	can_fire = false
	var sound_player := AudioStreamPlayer.new()
	sound_player.stream = sound
	sound_player.autoplay = true
	# warning-ignore:return_value_discarded
	sound_player.connect("finished", sound_player, "queue_free")
	add_child(sound_player)
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
