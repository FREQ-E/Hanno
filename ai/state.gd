# A base class for developing behaviours
class_name State
extends Node


signal loop_finished
signal _continue_loop

var active := false setget set_active


func set_active(value: bool) -> void:
	if value != active:
		active = value
		
		if value:
			_loop()
		
		else:
			emit_signal("_continue_loop")


func continue_loop() -> void:
	emit_signal("_continue_loop")


func _loop() -> void:
	# We loop this way so that the behaviour will only update when a change has occured
	# The scene tree's idle_frame signal can be connected to continue_loop to simulate _process
	while active:
		yield(self, "_continue_loop")
	
	emit_signal("loop_finished")
