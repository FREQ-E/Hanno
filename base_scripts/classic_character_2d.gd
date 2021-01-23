# EXtends the character script to have more natural movement through interpolation
# Also adds air strafing, which limits the air speed so there is no net acceleration
class_name ClassicCharacter2D
extends Character2D


export(float, 0, 1000) var acceleration_weight := 12.0			# weight used to interpolate velocity to the movement vector
export(float, 0, 1000) var brake_weight := 18.0					# weight used to interpolate velocity to 0
export(float, 0, 1000) var air_weight := 2.0					# weight used to interpolate air velocity


func _integrate_movement(vector: Vector2, delta: float) -> Vector2:
	return linear_velocity.linear_interpolate(vector, 1.0 - exp(- (acceleration_weight if vector.length() >= linear_velocity.length() else brake_weight) * delta))
