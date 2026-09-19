extends "res://ships/ship-ctrl.gd"

var pointersDT

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_hyb_maint_UV",self)
	dt_hyb_maint_UV()
	add_drones_to_hyb()

var have_maintenance_drones:bool = true
var impact_damage_mod:float = 2.0
var ke_damage_mod:float = 2.0
var emp_damage_mod:float = 2.0
var thermal_damage_mod:float = 2.0

func dt_hyb_maint_UV():
	have_maintenance_drones = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","hostiles_use_maintenance_drones")
	emp_damage_mod = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_SHIPS","emp_damage_modifier")
	impact_damage_mod = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_SHIPS","impact_damage_modifier")
	ke_damage_mod = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_SHIPS","kinetic_damage_modifier")
	thermal_damage_mod = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_SHIPS","thermal_damage_modifier")
	

func add_drones_to_hyb():
	if have_maintenance_drones and name == "HYB-base":
		addDronesCapacity(1000.0)
		addDrones(1000.0)
		setConfig("weaponSlot.hyb_main_mount.type","SYSTEM_DND_FIX")
		var drone_mount = load("res://DifficultyTweaker/ships/HYBDroneMounter.tscn")
		add_child(drone_mount.instance())

func applyIntegratedDamage(delta: float):
	if isPlayerControlled():
		for dmg in integratedDamage:
			integratedDamage[dmg][1] *= impact_damage_mod
	.applyIntegratedDamage(delta)

func applyKineticDamage(energy, point, delta = null):
	if energy > 0 and isPlayerControlled():
		energy *= ke_damage_mod
	.applyKineticDamage(energy,point,delta)

func applyEnergyDamage(energy, point, delta):
	if energy > 0 and isPlayerControlled():
		energy *= thermal_damage_mod
	.applyEnergyDamage(energy,point,delta)

func applyEmpDamage(energy, point, delta):
	if energy > 0 and isPlayerControlled():
		energy *= emp_damage_mod
	.applyEmpDamage(energy,point,delta)
