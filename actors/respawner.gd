class_name Respawner
extends Node


export var recovery_distance := 4000.0

var recoverer: Respawner
var player: Node2D

var _recovery_mode := false

onready var original_transform = get_parent().global_transform


func _ready():
	if _recovery_mode:
		player = GlobalFuncs.yield_and_get_group("Player")[0]
	
	else:
		recoverer = duplicate()
		recoverer._recovery_mode = true
		recoverer.filename = get_parent().filename
		set_process(false)


func _process(_delta):
	if player.global_transform.origin.distance_to(original_transform.origin) <= recovery_distance:
		var instance: Node2D = load(filename).instance()
		get_parent().add_child(instance)
		instance.global_transform = original_transform
		queue_free()


func _exit_tree():
	if not _recovery_mode:
		get_parent().get_parent().add_child(recoverer)
