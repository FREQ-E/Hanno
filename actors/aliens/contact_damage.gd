class_name ContactDamage
extends Area2D


export var damage := 0.5
export var damage_rate := 0.5
export var target_group := "Player"

var _timer: float


func _physics_process(delta):
	if _timer <= 0:
		for node in get_overlapping_bodies():
			if node.is_in_group(target_group):
				node.get_node("Damageable").health -= damage
				_timer = damage_rate
	
	else:
		_timer -= delta
