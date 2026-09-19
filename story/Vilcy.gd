extends "res://story/Vilcy.gd"

onready var original_chaos = chaosLimit
onready var original_lockout = lockOutStory
onready var original_require = requireStory
onready var original_max_depth = depthMaxKm
onready var original_min_depth = depthMinKm
onready var original_min_capacity = minCapacity
onready var original_min_money = minMoney

var pointersDT:HevLibPointers._ConfigDriver

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_vilcy_g4a_UV",self)
	dt_vilcy_g4a_UV()

var always_revenger:bool = true
var have_maintenance_drones:bool = true

func dt_vilcy_g4a_UV():
	always_revenger = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","always_vilcy_g4a_revenger")
	have_maintenance_drones = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","hostiles_use_maintenance_drones")
	
	if pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","remove_event_limits"):
		chaosLimit = 0
		lockOutStory = ""
		requireStory = ""
		depthMaxKm = 3006
		depthMinKm = 0
		minCapacity = 0
		minMoney = 0
	else:
		chaosLimit = original_chaos
		lockOutStory = original_lockout
		requireStory = original_require
		depthMaxKm = original_max_depth
		depthMinKm = original_min_depth
		minCapacity = original_min_capacity
		minMoney = original_min_money

var desiredFactions:PoolStringArray = PoolStringArray(["pirate","vilcy"])

func makeAt(pos):
	var out = .makeAt(pos)
	if out is Array:
		for i in out.size():
			var obj = out[i]
			if "fullConfig" in obj and obj.fullConfig.get("faction","") in desiredFactions:
				if always_revenger:
					obj = makeRevenger(obj)
				if have_maintenance_drones:
					match obj.model:
						"TRTL":
							obj.shipConfig.weaponSlot.right = {
								"type":"SYSTEM_DND_FIX"
							}
							obj.shipConfig.drones = {
								"capacity":5000,
								"initial":5000
							}
						"MADCERF":
							obj.shipConfig.weaponSlot.right3 = {"type":"SYSTEM_DND_FIX"}
							
							obj.shipConfig.turbine.power = 2000
							obj.shipConfig.drones = {
								"capacity":15000,
								"initial":15000
							}
							obj.shipConfig.ammo = {
								"capacity":50000,
								"initial":50000
							}
				out[i] = obj
	return out
