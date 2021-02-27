class_name CharacterAnimator
extends AnimatedSprite


export var default_movement_speed := 770.0				# The speed the parent has to move at such that the speed_scale is 1. Moving faster would cause the animation speed to speed up, and vice versa
export var invert_x := false

onready var _last_origin: Vector2 = get_parent().global_transform.origin


func _process(delta):
	if is_zero_approx(get_parent().movement_vector.length()):
		stop()
		frame = 1
	
	elif delta > 0:
		var angle := global_transform.basis_xform_inv(get_parent().movement_vector).angle()
		var new_origin: Vector2 = get_parent().global_transform.origin
		speed_scale = new_origin.distance_to(_last_origin) / delta / default_movement_speed
		_last_origin = new_origin
		
		if angle < - PI / 4 and angle > - 3 * PI / 4:
			play("walk_up")
		
		elif angle > PI / 4 and angle < 3 * PI / 4:
			play("walk_down")
		
		else:
			play("walk_side")
			
			if abs(angle) > PI / 2 != invert_x:
				global_transform.x *= -1
