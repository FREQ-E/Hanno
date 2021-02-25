# A base class for developing 2D terrestrial entities which are controllable by both AI and users through a common interface
class_name Character2D
extends KinematicBody2D


export(float, 0, 1000) var acceleration_weight := 12.0			# weight used to interpolate velocity to the movement vector
export(float, 0, 1000) var brake_weight := 18.0					# weight used to interpolate velocity to 0


# The speed and direction this character is moving towards
var linear_velocity: Vector2

# the speed and direction this character will move towards (in global space)
var movement_vector: Vector2


func _integrate_movement(vector: Vector2, delta: float) -> Vector2:
	# transforms the vector given according to some algorithm
	# this is mainly used to determine how the movement_vector affects the linear_velocity
	# right now this will only allow the character to move when it is on the ground
	# linear_velocity should not be set in this function
	return linear_velocity.linear_interpolate(vector, 1.0 - exp(- (acceleration_weight if vector.length() >= linear_velocity.length() else brake_weight) * delta))


func _physics_process(delta: float):
	linear_velocity = move_and_slide(_integrate_movement(movement_vector, delta))
