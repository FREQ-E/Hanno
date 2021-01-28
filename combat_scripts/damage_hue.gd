class_name DamageHue
extends Node


export(float, 0, 1) var max_hue := 0.5
export(float, 0, 1) var max_saturation := 1.0		# in order for hue to change, saturation must change too
export var damageable_path: NodePath = "../Damageable"

onready var damageable: Damageable = get_node(damageable_path)


func _ready():
	damageable.connect("damaged", self, "_handle_damaged")


func _handle_damaged(_value) -> void:
	var fraction := 1 - damageable.health / damageable.max_health
	print(fraction)
	get_parent().modulate.h = max_hue * fraction
	get_parent().modulate.s = max_saturation * fraction
