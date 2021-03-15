class_name Enemy
extends Character2D


onready var node_sight: NodeSight2D = $NodeSight2D
onready var dynamic_ysort: DynamicYSort = $DynamicYSort
onready var contact_damage: ContactDamage = $ContactDamage


func _process(delta):
	node_sight.update()
	contact_damage.process_contact_damage(delta)
	
	if dynamic_ysort.is_on_screen():
		z_index = dynamic_ysort.get_z_index()
