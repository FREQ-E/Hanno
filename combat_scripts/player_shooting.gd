# A quick node to allow a controllabe Character to shoot
# Must be a direct child of the Character
class_name PlayerShooting
extends Node2D


export var bullet_speed := 1000
export var fire_rate := 0.2

var bullet_scene = preload("res://actors/player1/player_bullet.tscn")
var can_fire = true


func _process(_delta):
	if not can_fire:
		return
	
	var vector := Vector2(Input.get_action_strength("fire_right") - Input.get_action_strength("fire_left"), Input.get_action_strength("fire_down") - Input.get_action_strength("fire_up")).normalized()
	
	if vector.is_normalized():		# even though vector was normalized, it could still be length 0 if no key was pressed
		var bullet_instance = bullet_scene.instance()
		bullet_instance.transform = global_transform
		bullet_instance.linear_velocity = vector * bullet_speed
		get_tree().current_scene.add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
