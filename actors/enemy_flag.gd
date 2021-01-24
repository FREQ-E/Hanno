# A node flag specifically for enemies (because enemies is an array in GlobalData)
class_name EnemyFlag
extends Node


export var auto_remove := true


func _enter_tree():
	GlobalData.enemies.append(get_parent())


func _exit_tree():
	if auto_remove:
		GlobalData.enemies.erase(get_parent())
