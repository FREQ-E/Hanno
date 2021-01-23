extends Node


signal player_changed

var player: Node setget set_player
var enemies: Array


func set_player(node: Node) -> void:
	player = node
	emit_signal("player_changed")
