# A quick node to allow a character to be controlled by user input
# Must be a direct child of the Character
class_name MovementInput2D
extends Node


#export var fast_speed := 10.0
export var default_speed := 5.0
export var basis_node_path: NodePath			# If given, the user input will be transformed to be relative to the node given

var basis_node: Node2D


func _ready():
	if not basis_node_path.is_empty():
		basis_node = get_node(basis_node_path)


func _process(_delta):
	# the following magic with movement_vector allows finer control with joystick/joypad
	var x := Input.get_action_strength("move right") - Input.get_action_strength("move left")
	var y := Input.get_action_strength("move down") - Input.get_action_strength("move up")
	var movement_vector := Vector2(x, y).normalized() * max(abs(x), abs(y))
	
#	if Input.is_action_pressed("sprint"):
#		movement_vector *= fast_speed
#
#	else:
	movement_vector *= default_speed
	
	if is_instance_valid(basis_node):
		get_parent().movement_vector = basis_node.global_transform.basis_xform(movement_vector)
	
	else:
		get_parent().movement_vector = movement_vector
