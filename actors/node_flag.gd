# Adds the parent to a property in GlobalData
class_name NodeFlag
extends Node


export var property_name: String
export var auto_remove := false


func _enter_tree():
	GlobalData.set(property_name, get_parent())


func _exit_tree():
	if auto_remove:
		GlobalData.set(property_name, null)
