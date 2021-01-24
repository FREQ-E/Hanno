class_name CharacterAnimator
extends AnimatedSprite


func _process(_delta):
	play("default" if is_zero_approx(get_parent().movement_vector.length()) else "walk_forward")
