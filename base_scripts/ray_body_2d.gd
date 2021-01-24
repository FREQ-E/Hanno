# A simple dot shaped "PhysicsBody" for bullets
class_name RayBody2D
extends RayCast2D


signal collided

export var linear_velocity: Vector2

var _was_colliding := false


func _physics_process(delta):
	if is_colliding():
		if not _was_colliding:
			emit_signal("collided")
		
		global_transform.origin = get_collision_point()
		_was_colliding = true
	
	else:
		global_transform.origin += linear_velocity * delta
		_was_colliding = false
		
	cast_to = global_transform.basis_xform_inv(linear_velocity * delta)
