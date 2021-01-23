# A base class for developing 2D terrestrial entities which are controllable by both AI and users through a common interface
class_name Character2D
extends KinematicBody2D


# The speed and direction this character is moving towards. Do not set this directly if snapped to floor, use apply_impulse
var linear_velocity: Vector2

# the speed and direction this character will move towards (in global space)
var movement_vector: Vector2


func _integrate_movement(vector: Vector2, _delta: float) -> Vector2:
	# transforms the vector given according to some algorithm
	# this is mainly used to determine how the movement_vector affects the linear_velocity
	# right now this will only allow the character to move when it is on the ground
	# linear_velocity should not be set in this function
	return linear_velocity


func _physics_process(delta: float):
	linear_velocity = move_and_slide(_integrate_movement(movement_vector, delta))
