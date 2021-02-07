class_name EnemyShooting
extends Node2D


export var bullet_speed := 1000
export var fire_rate := 0.2
export var trigger_node_path: NodePath = "../NodeSight"
export var firing_angle_degrees := 10.0
export(PackedScene) var bullet_scene := preload("res://actors/aliens/enemy_bullet.tscn")

var target: Node2D
var can_fire := true
var timer := Timer.new()

onready var firing_angle := deg2rad(firing_angle_degrees)
onready var trigger_node = get_node(trigger_node_path)


func _ready():
	trigger_node.connect("triggered", self, "set_process", [true])
	trigger_node.connect("triggered", self, "update_target")
	trigger_node.connect("untriggered", self, "set_process", [false])
	set_process(false)
	timer.one_shot = true
	timer.connect("timeout", self, "reload")
	add_child(timer)


func update_target() -> void:
	target = trigger_node.target


func reload() -> void:
	can_fire = true


func _process(_delta):
	if not can_fire:
		return
	
	var rel_vec := target.global_transform.origin - global_transform.origin
	var dir: Vector2
	
	if abs(rel_vec.angle_to(Vector2.UP)) <= firing_angle:
		dir = Vector2.UP
	
	elif abs(rel_vec.angle_to(Vector2.DOWN)) <= firing_angle:
		dir = Vector2.DOWN
	
	elif abs(rel_vec.angle_to(Vector2.LEFT)) <= firing_angle:
		dir = Vector2.LEFT
	
	elif abs(rel_vec.angle_to(Vector2.RIGHT)) <= firing_angle:
		dir = Vector2.RIGHT
	
	else:
		return
	
	var bullet_instance = bullet_scene.instance()
	bullet_instance.transform = global_transform
	bullet_instance.linear_velocity = dir * bullet_speed
	get_tree().current_scene.add_child(bullet_instance)
	can_fire = false
	timer.start(fire_rate)
