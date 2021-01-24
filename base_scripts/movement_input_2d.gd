# A quick node to allow a character to be controlled by user input
# Must be a direct child of the Character
class_name MovementInput2D
extends Node

signal dashed
signal undashed


export var fast_speed := 11.7
export var default_speed := 8

export var dash_speed := 20.0					# the speed the character travels during the dash
export var dash_duration := 0.07					# how long the dash lasts
export var dash_buffer := 0.2					# the window of time available in which sprint can be pressed and released to trigger the dash

export var basis_node_path: NodePath			# If given, the user input will be transformed to be relative to the node given

var basis_node: Node2D
var movement_vector: Vector2
var dashing := false setget set_dashing			# if true, the character will dash until an obstacle is hit (or if triggered through sprint, will self disable after dash_duration)

var _last_sprint_time_msecs: int				# the system time the last time the sprint button was pressed


func set_dashing(value: bool) -> void:
	if value != dashing:
		if value:
			movement_vector = movement_vector.normalized() * dash_speed
			emit_signal("dashed")
		
		else:
			movement_vector = movement_vector.normalized() * default_speed
			emit_signal("undashed")
		
		get_parent().linear_velocity = movement_vector		# hard set the value for sharper velocity changes
	
	dashing = value


func _ready():
	if not basis_node_path.is_empty():
		basis_node = get_node(basis_node_path)


func _input(event):
	if event.is_action_pressed("sprint"):
		_last_sprint_time_msecs = OS.get_system_time_msecs()
	
	elif not dashing and not is_zero_approx(movement_vector.length()) and event.is_action_released("sprint") and (OS.get_system_time_msecs() - _last_sprint_time_msecs) / 1000.0 <= dash_buffer:
		set_dashing(true)
		yield(get_tree().create_timer(dash_duration), "timeout")
		set_dashing(false)


func _process(_delta):
	# the following magic with movement_vector allows finer control with joystick/joypad
	if dashing:
		if get_parent().get_slide_count() > 0:
			set_dashing(false)
	
	else:
		var x := Input.get_action_strength("move right") - Input.get_action_strength("move left")
		var y := Input.get_action_strength("move down") - Input.get_action_strength("move up")
		movement_vector = Vector2(x, y).normalized() * max(abs(x), abs(y))
		
		if Input.is_action_pressed("sprint"):
			movement_vector *= fast_speed
		
		else:
			movement_vector *= default_speed
	
	if is_instance_valid(basis_node):
		get_parent().movement_vector = basis_node.global_transform.basis_xform(movement_vector)
	
	else:
		get_parent().movement_vector = movement_vector
