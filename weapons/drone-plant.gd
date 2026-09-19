extends "res://weapons/drone-plant.gd"

var pointersDT

onready var base_disp_per_second = dispositionPerSecondFix
func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_vilcy_g4a_UV",self)
	dt_vilcy_g4a_UV()

func dt_vilcy_g4a_UV():
	dispositionPerSecondFix = base_disp_per_second * pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_SHIPS","reduce_maintenance_drone_disposition_gain")
