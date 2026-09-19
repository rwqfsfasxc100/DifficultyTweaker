extends "res://story/LocustSwarm.gd"

onready var original_chaos = chaosLimit
onready var original_lockout = lockOutLimit
onready var original_require_min = requireMin
onready var original_away = awayRadius

var pointersDT:HevLibPointers._ConfigDriver

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_remove_restrictions_UV",self)
	dt_remove_restrictions_UV()

func dt_remove_restrictions_UV():
	if pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","remove_event_limits"):
		chaosLimit = 0
		lockOutLimit = 0xFFFFFFFFFFFFFF
		requireMin = -2
		awayRadius = 0.0000001
	else:
		chaosLimit = original_chaos
		lockOutLimit = original_lockout
		requireMin = original_require_min
		awayRadius = original_away
