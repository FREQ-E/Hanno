# Wanders around, moving a minimum distance of min_wander_distance, and no further than max_wander_distance
class_name Wander2D
extends State


export var max_wander_distance := 100.0
export var min_wander_distance := 50.0
export var speed := 200.0
export var wander_pause := 0.0
export var revolve_around_origin := false				# if true, will wander around the origin of the character when this node was ready. Else, random origins will revolve around the characters current position

var timer := Timer.new()

onready var character = get_parent().get_parent()
onready var original_origin: Vector2 = get_parent().get_parent().global_transform.origin


func _ready():
	set_process(false)
	add_child(timer)
	timer.one_shot = true
	# warning-ignore:return_value_discarded
	timer.connect("timeout", self, "continue_loop")


func _loop() -> void:
	get_parent().goto.one_shot = true
	get_parent().goto.speed = speed
	get_parent().goto.connect("finished", self, "continue_loop")
	set_process(true)
	
	while active:
		if wander_pause > 0:
			timer.start(wander_pause)
			yield(self, "_continue_loop")
			timer.stop()		# just in case loop was halted and the timer is still running
		
		if not active:
			break
		
		get_parent().goto.enabled = true
		get_parent().goto.target_origin = Vector2.UP.rotated(rand_range(0, TAU)) * lerp(min_wander_distance, max_wander_distance, randf()) + (original_origin if revolve_around_origin else get_parent().get_parent().global_transform.origin)
		yield(self, "_continue_loop")
	
	get_parent().goto.enabled = false
	get_parent().goto.disconnect("finished", self, "continue_loop")
	set_process(false)
	emit_signal("loop_finished")


func _process(_delta):
	if character.is_on_wall():
		get_parent().goto.enabled = false
		continue_loop()
