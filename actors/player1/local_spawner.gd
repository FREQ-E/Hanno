class_name LocalSpawner
extends Node


# warning-ignore:unused_signal
signal _continue_loop

export(Array, PackedScene) var scenes: Array
export var probability_curve: Curve
export var min_distance := 1000.0
export var max_distance := 2000.0
export var max_instances := 10
export var spawn_in_ysort := true

var instances: Array

onready var player_origin: Vector2 = get_parent().global_transform.origin


func _ready():
	var current_scene := get_tree().current_scene
	
	if spawn_in_ysort:
		current_scene = current_scene.get_node("YSort")
	
	for _i in range(max_instances):
		var instance: Node2D = scenes[int(round(probability_curve.interpolate(randf())))].instance()
		instance.transform.origin = Vector2.UP.rotated(randf() * TAU) * lerp(min_distance, max_distance, randf()) + player_origin
		# warning-ignore:return_value_discarded
		instance.connect("tree_exited", self, "emit_signal", ["_continue_loop"])
		current_scene.call_deferred("add_child", instance)
	
	while true:
		yield(self, "_continue_loop")
		
		if not is_inside_tree():
			return
		
		var instance: Node2D = scenes[int(round(probability_curve.interpolate(randf())))].instance()
		instances.append(instance)
		instance.transform.origin = Vector2.UP.rotated(randf() * TAU) * lerp(min_distance, max_distance, randf()) + player_origin
		# warning-ignore:return_value_discarded
		instance.connect("tree_exited", self, "emit_signal", ["_continue_loop"])
		current_scene.add_child(instance)


func _process(_delta):
	player_origin = get_parent().global_transform.origin
	
	var i := 0
	while i < instances.size():
		var instance: Node2D = instances[i]
		
		if is_instance_valid(instance):
			if player_origin.distance_to(instance.global_transform.origin) >= max_distance:
				instance.queue_free()
				instances.remove(i)
			
			else:
				i += 1
		
		else:
			instances.remove(i)
