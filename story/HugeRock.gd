extends "res://story/HugeRock.gd"

var pointersDT:HevLibPointers._ConfigDriver

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_vilcy_g4a_UV",self)
	dt_vilcy_g4a_UV()

func dt_vilcy_g4a_UV():
	always_revenger = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","always_vilcy_g4a_revenger")
	have_maintenance_drones = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","hostiles_use_maintenance_drones")
var always_revenger:bool = true
var have_maintenance_drones:bool = true

func makeg4a():
	var obj = .makeg4a()
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
	return obj

func makeRevenger(ship):
	ship.aiHunterEngagementDistance = 15000.0
	ship.aiHunterTalkDistance = 30000.0
	ship.aiHunterFireDistance = 25000.0
	ship.aiHunterMaxVelocity = 900
	ship.aiHunterAccurancy = 0.925
	ship.aiCuriosityDisance = 20000.0
	return ship
