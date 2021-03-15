class_name CrystalManager
extends Node


signal crystals_changed

export var crystals: int setget set_crystals


func set_crystals(value: int) -> void:
	crystals = value
	emit_signal("crystals_changed")
