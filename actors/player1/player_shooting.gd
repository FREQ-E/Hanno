# A quick node to allow a controllabe Character to shoot
# Must be a direct child of the Character
class_name PlayerShooting
extends Node2D


export var bullet_speed := 1000
export var damage := 0.5
export var fire_rate := 0.2
export(PackedScene) var bullet_scene := preload("res://actors/player1/player_bullet.tscn")
export var sound: AudioStream

var can_fire := true
var buff_timer: float

onready var default_damage := damage


func _process(delta):
	if buff_timer > 0:
		buff_timer -= delta
	
		if buff_timer <= 0:
			damage = default_damage
	
	if not can_fire:
		return
	
	var dir : Vector2
	
	if Input.is_action_pressed("fire_up"):
		dir = Vector2.UP
		
	elif Input.is_action_pressed("fire_left"):
		dir = Vector2.LEFT
		
	elif Input.is_action_pressed("fire_down"):
		dir = Vector2.DOWN
		
	elif Input.is_action_pressed("fire_right"):
		dir = Vector2.RIGHT
	
	else:
		return
	
	var bullet_instance = bullet_scene.instance()
	bullet_instance.damage = damage
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
