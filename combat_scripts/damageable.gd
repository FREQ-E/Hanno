# Adds health functionality to the parent
class_name Damageable
extends Node


signal death
signal healed(value)
signal damaged(value)

export var max_health := 3.0 setget set_max_health
export var health := 3.0 setget set_health


func set_max_health(value: float) -> void:
	max_health = value
	if health > max_health:
		health = max_health


func set_health(value: float) -> void:
	if value < health:
		emit_signal("damaged", health - value)
	
	elif value > health:
		emit_signal("healed", value - health)
	
	health = value
	
	if health > max_health:
		health = max_health
	
	elif health <= 0:
		emit_signal("death")
