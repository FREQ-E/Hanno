class_name CrystalBody
extends VisibilityNotifier2D


export var value := 1

var spawn_check := false			# set by the spawner, if true, will queue_free if was on screen when spawning

onready var player: Node = GlobalFuncs.yield_and_get_group("Player")[0]


func _ready():
	if spawn_check:
		yield(get_tree(), "idle_frame")
		
		if is_on_screen():
			queue_free()
			return
	
	# warning-ignore:return_value_discarded
	$Area2D.connect("body_entered", self, "_handle_body_entered")


func _handle_body_entered(body: Node) -> void:
	if body == player:
		player.get_node("CrystalManager").crystals += value
		queue_free()
