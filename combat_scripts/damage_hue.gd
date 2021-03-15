class_name DamageHue
extends Node


export(float, 0, 1) var max_hue := 0.5
export(float, 0, 1) var max_saturation := 1.0		# in order for hue to change, saturation must change too

onready var damageable: HealthComponent = get_parent()


func _ready():
	# warning-ignore:return_value_discarded
	damageable.connect("damaged", self, "_handle_damaged")


func _handle_damaged(_value) -> void:
	var fraction := 1 - damageable.health / damageable.max_health
	damageable.get_parent().modulate.h = max_hue * fraction
	damageable.get_parent().modulate.s = max_saturation * fraction
