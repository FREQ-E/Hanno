# A quick node to allow a controllabe Character to shoot
# Must be a direct child of the Character
class_name PlayerShooting
extends Node2D


export var bullet_speed := 1000
export var fire_rate := 0.2
export(PackedScene) var bullet_scene := preload("res://actors/player1/player_bullet.tscn")

var can_fire := true


func _process(_delta):
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
	bullet_instance.transform = global_transform
	bullet_instance.linear_velocity = dir * bullet_speed
	get_tree().current_scene.add_child(bullet_instance)
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
