class_name BaseBullet
extends RigidBody2D


export var target_group := "enemies"
export var damage := 0.5


func _ready():
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "_handle_collision")


func _handle_collision(body: Node) -> void:
	queue_free()
	
	if body.is_in_group(target_group):
		# decrement health here @Zekda
		body.get_node('Damageable').health -= damage
		print('Life left ', body.get_node('Damageable').health/body.get_node('Damageable').max_health,'%')
		
		pass
