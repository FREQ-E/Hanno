class_name ContactDamage
extends Area2D


export var damage := 0.5
export var damage_rate := 0.5
export var target_group := "Player"

var _timer: float


func process_contact_damage(delta):
	if _timer <= 0:
		for node in get_overlapping_bodies():
			if node.is_in_group(target_group):
				node.health_component.health -= damage
				_timer = damage_rate
	
	else:
		_timer -= delta
