class_name CrystalBody
extends Area2D


export var value := 1

onready var player: Node = GlobalFuncs.yield_and_get_group("Player")[0]


func _ready():
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "_handle_body_entered")


func _handle_body_entered(body: Node) -> void:
	if body is StaticBody2D or body is TileMap:
		queue_free()
	
	elif body == player:
		player.get_node("CrystalManager").crystals += value
		queue_free()
