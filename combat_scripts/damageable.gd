# Adds health functionality to the parent
class_name Damageable
extends Node


const DAMAGE_FLASH_DURATION := 0.2		# The reason why this is constant is consistency across all entities when damaged

signal death
signal healed(value)
signal damaged(value)

export var max_health := 3.0 setget set_max_health
export var health := 3.0 setget set_health
export var invincible := false						# if true, won't take damage
export var undying := false setget set_undying		# if true, won't die when health drops below 0. If health was below 0 and undying is set to false, death will be emitted
export var unhealing := false						# if true, won't be able to heal

var _is_ready := false


func _ready():
	_is_ready = true


func set_max_health(value: float) -> void:
	max_health = value
	
	if health > max_health:
		health = max_health


func set_health(value: float) -> void:
	if not _is_ready:
		health = value
		return
	
	var difference := health - value
	if difference > 0:
		if invincible:
			emit_signal("damaged", difference)
		
		else:
			health = value
			emit_signal("damaged", difference)
			
			if health < 0 and not undying:
				emit_signal("death")
			
			else:
				flash()
	
	elif difference < 0:
		if unhealing:
			emit_signal("healed", - difference)
		
		else:
			health = value
			emit_signal("healed", - difference)
			
			if health > max_health:
				health = max_health


func set_undying(value: bool) -> void:
	undying = value
	
	if not value and health <= 0:
		emit_signal("death")


func flash() -> void:
	# NOTE, FOR THE FLASH MECHANIC TO WORK THE PARENT MUST HAVE A invert_material.tres ASSIGNED AS MATERIAL
	# THE VISUAL CHILDREN (SPRITES) SHOULD ALSO HAVE USE_PARENT_MATERIAL ENABLED
	get_parent().material.set_shader_param("invert", true)
	yield(get_tree().create_timer(DAMAGE_FLASH_DURATION), "timeout")
	get_parent().material.set_shader_param("invert", false)
