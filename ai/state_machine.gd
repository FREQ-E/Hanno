# A base class which activates or deactivates states based on the trigger node given
class_name StateMachine
extends Node


export var trigger_node_path: NodePath = "../NodeSight"
export var goto_path: NodePath = "../Goto"

onready var trigger_node = get_node(trigger_node_path)
onready var goto = get_node(goto_path)


func _ready():
	trigger_node.connect("triggered", self, "_handle_triggered")
	trigger_node.connect("untriggered", self, "_handle_untriggered")


func _handle_untriggered() -> void:
	return


func _handle_triggered() -> void:
	return
