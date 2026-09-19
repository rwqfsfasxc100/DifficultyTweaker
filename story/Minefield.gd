extends "res://story/Minefield.gd"

onready var original_chaos = chaosLimit
onready var original_min_money = minMoney
onready var original_min_capacity = minCapacity
onready var original_max_ships = shipLimit

var pointersDT:HevLibPointers._ConfigDriver

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_remove_restrictions_UV",self)
	dt_remove_restrictions_UV()

func dt_remove_restrictions_UV():
	if pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","remove_event_limits"):
		chaosLimit = 0
		minMoney = 0
		minCapacity = 0
		shipLimit = 0xFF
	else:
		chaosLimit = original_chaos
		minMoney = original_min_money
		minCapacity = original_min_capacity
		shipLimit = original_max_ships
