extends Control

onready var label = get_node("HBoxContainer/Counters/PurpleCounter/Number")
onready var player: Node = GlobalFuncs.yield_and_get_group("Player")[0]

# Update crystal counter on the GUI
func _process(delta: float) -> void:
	label.text = str(player.get_node("CrystalManager").crystals)
	
