# A behaviour which activates a behaviour when triggered, and another when untriggered
# The default paths are for a behaviour which causes the parent to wander when untriggered and chase the target when triggered
class_name TriggerUntrigger
extends StateMachine


export var untrigger_behaviour_path: NodePath = "Wander2D"
export var trigger_behaviour_path: NodePath = "Agro2D"

onready var untrigger_behaviour: State = get_node(untrigger_behaviour_path)
onready var trigger_behaviour: State = get_node(trigger_behaviour_path)


func _ready():
	_handle_untriggered()


func _handle_untriggered() -> void:
	if trigger_behaviour.active:
		trigger_behaviour.active = false
	
	untrigger_behaviour.active = true


func _handle_triggered() -> void:
	if untrigger_behaviour.active:
		untrigger_behaviour.active = false
	
	trigger_behaviour.active = true
