class_name CharacterAnimator
extends AnimatedSprite


export var default_movement_speed := 770.0				# The speed the parent has to move at such that the speed_scale is 1. Moving faster would cause the animation speed to speed up, and vice versa
export var invert_x := false

var _first_frame := true
var _last_origin: Vector2


func process_animation(delta: float, movement_vector: Vector2, new_origin: Vector2):
	_first_frame = false
	
	if is_zero_approx(movement_vector.length()):
		stop()
		frame = 1
	
	elif delta > 0:
		var angle := global_transform.basis_xform_inv(movement_vector).angle()
		
		if not _first_frame:
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
