extends "res://story/LifepodIsFloating.gd"

var pointersDT:HevLibPointers._ConfigDriver

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_vilcy_g4a_UV",self)
	dt_vilcy_g4a_UV()

func dt_vilcy_g4a_UV():
	cargo_multi_val = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","reduce_rogue_thicc_contents")

var cargo_multi_val:float = 0.75

func addProcessedCargo(i):
	var baseMin:float = processedCargoMin
	var baseMax:float = processedCargoMax
	processedCargoMin *= cargo_multi_val
	processedCargoMax *= cargo_multi_val
	.addProcessedCargo(i)
	processedCargoMin = baseMin
	processedCargoMax = baseMax
