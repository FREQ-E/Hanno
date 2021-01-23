extends Node


signal player_changed

var player: Character2D setget set_player
var enemies: Array


func set_player(node: Character2D) -> void:
	player = node
	emit_signal("player_changed")
