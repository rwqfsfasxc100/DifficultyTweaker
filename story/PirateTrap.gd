extends "res://story/PirateTrap.gd"

onready var original_chaos = chaosLimit
onready var original_min_depth = depthMinKm
onready var original_max_depth = depthMaxKm
onready var original_lock_out = lockOutLimit
onready var original_min_money = minMoney
onready var original_away_radius = awayRadius

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
		depthMinKm = 0
		depthMaxKm = 3006
		lockOutLimit = 0xFFFFFFFFFFFFFF
		minMoney = 0
		awayRadius = 0.0000001
	else:
		chaosLimit = original_chaos
		depthMinKm = original_min_depth
		depthMaxKm = original_max_depth
		lockOutLimit = original_lock_out
		minMoney = original_min_money
		awayRadius = original_away_radius

func makeAt(pos):
	var out = .makeAt(pos)
	if out is Array:
		for i in out.size():
			var obj = out[i]
			if "fullConfig" in obj and obj.fullConfig.get("faction","") == "pirate":
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

func makeRevenger(ship):
	ship.aiHunterEngagementDistance = 15000.0
	ship.aiHunterTalkDistance = 30000.0
	ship.aiHunterFireDistance = 25000.0
	ship.aiHunterMaxVelocity = 900
	ship.aiHunterAccurancy = 0.925
	ship.aiCuriosityDisance = 20000.0
	return ship

