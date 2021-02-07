class_name RespawnFlag
extends Node


export var distance := 4000.0


func _ready():
	get_parent().get_parent().track_respawn_target(self)
