class_name CrystalBody
extends Area2D


export var value := 1

onready var player: Node = GlobalFuncs.yield_and_get_group("Player")[0]


func _ready():
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "_handle_node_entered")
	connect("area_entered", self, "_handle_node_entered")


func _handle_node_entered(body: Node) -> void:
	if body is StaticBody2D or body is TileMap or body is Area2D:
		pass
	
	elif body == player:
		_handle_player_entered()
	
	queue_free()


func _handle_player_entered() -> void:
	player.crystals += value
