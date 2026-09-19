extends "res://TheRing.gd"

func _ready():
	if ModLoader._savedObjects[0].ConfigDriver.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_EVENTS","remove_starting_npcs"):
		diggerEvery = 0x7fffffffffffffff
