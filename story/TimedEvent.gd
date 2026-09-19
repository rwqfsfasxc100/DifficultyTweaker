extends "res://story/TimedEvent.gd"

onready var original_chaos = chaosLimit
onready var original_away = awayRadius

var pointersDT:HevLibPointers._ConfigDriver

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_remove_restrictions_UV",self)
	dt_remove_restrictions_UV()

func dt_remove_restrictions_UV():
	if pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","remove_event_limits"):
		chaosLimit = 0
		awayRadius = 0.0000001
	else:
		chaosLimit = original_chaos
		awayRadius = original_away
