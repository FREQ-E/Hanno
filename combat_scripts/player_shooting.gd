# A quick node to allow a controllabe Character to shoot
# Must be a direct child of the Character
class_name PlayerShooting
extends Node

export var bullet_speed = 1000
export var fire_rate = 0.2

var bullet = preload("res://actors/player1/player_bullet.tscn")
var can_fire = true
var rot_angle = 0
export (NodePath) var bullet_point_path = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	if (Input.is_action_pressed("fire_up") or
	Input.is_action_pressed("fire_left") or
	Input.is_action_pressed("fire_down") or
	Input.is_action_pressed("fire_right")) and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_node(bullet_point_path).global_position
		bullet_instance.rotation_degrees = get_parent().rotation_degrees
		
		if Input.is_action_pressed("fire_up"):
			rot_angle = deg2rad(270)
		if Input.is_action_pressed("fire_left"):
			rot_angle = deg2rad(180)
		if Input.is_action_pressed("fire_down"):
			rot_angle = deg2rad(90)
		if Input.is_action_pressed("fire_right"):
			rot_angle = deg2rad(0)
			
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rot_angle))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
