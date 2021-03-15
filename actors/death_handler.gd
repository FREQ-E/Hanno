class_name DeathHandler
extends HealthComponent


export var death_scene: PackedScene


func _ready():
	yield(self, "death")
	var instance := death_scene.instance()
	instance.transform = get_parent().transform
	get_parent().get_parent().add_child(instance)
	get_parent().queue_free()
