class_name CrystalBody
extends Area2D


export var value := 1

onready var player: Node = GlobalFuncs.yield_and_get_group("Player")[0]


func _ready():
	connect("body_entered", self, "_handle_body_entered")


func _handle_body_entered(body: Node) -> void:
	if body == player:
		player.get_node("CrystalManager").crystals += value
		queue_free()
