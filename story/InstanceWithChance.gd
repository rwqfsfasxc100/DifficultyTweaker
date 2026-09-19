extends "res://story/InstanceWithChance.gd"

onready var original_chaos = chaosLimit
onready var original_lockout = lockOutEvent
onready var original_lockout_this = lockOutMyEvent
onready var original_lockout_poi = lockoutPoi
onready var original_lockout_story = lockOutStory
onready var original_away = awayRadius
onready var original_density = maxDensity

var pointersDT:HevLibPointers._ConfigDriver

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_remove_restrictions_UV",self)
	dt_remove_restrictions_UV()

func dt_remove_restrictions_UV():
	if pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","remove_event_limits"):
		chaosLimit = 0
		lockOutEvent = ""
		lockOutMyEvent = false
		lockoutPoi = ""
		lockOutStory = ""
		awayRadius = 0.0000001
		maxDensity = PoolIntArray([1000, 1000, 1000, 1000, 1000])
	else:
		chaosLimit = original_chaos
		lockOutEvent = original_lockout
		lockOutMyEvent = original_lockout_this
		lockoutPoi = original_lockout_poi
		lockOutStory = original_lockout_story
		awayRadius = original_away
		maxDensity = original_density
