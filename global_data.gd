extends Node


signal player_changed
signal navigation_changed

var player: Node setget set_player
var enemies: Array
var navigation: Node setget set_navigation


func set_player(node: Node) -> void:
	player = node
	emit_signal("player_changed")


func set_navigation(node: Node) -> void:
	navigation = node
	emit_signal("navigation_changed")
