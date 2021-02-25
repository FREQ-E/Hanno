class_name BaseBullet
extends RigidBody2D


export var target_group := "Enemies"

var damage: float


func _ready():
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "_handle_collision")
	# warning-ignore:narrowing_conversion
	z_index = get_viewport().size.y + 1		# this is to always get it to spawn in front of all other nodes


func _handle_collision(body: Node) -> void:
	queue_free()
	
	if body.is_in_group(target_group):
		body.get_node('Damageable').health -= damage
