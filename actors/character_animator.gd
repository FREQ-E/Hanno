class_name CharacterAnimator
extends AnimatedSprite


func _process(_delta):
	if is_zero_approx(get_parent().movement_vector.length()):
		stop()
		frame = 1
	
	else:
		var local: Vector2 = get_parent().global_transform.basis_xform_inv(get_parent().movement_vector)
		
		if local.y > 0:
			play("walk_down")
		
		elif local.y < 0:
			play("walk_up")
		
		elif local.x > 0:
			play("walk_right")
		
		else:
			play("walk_left")
