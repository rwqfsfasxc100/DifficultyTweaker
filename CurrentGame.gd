extends "res://CurrentGame.gd"

var pointersDT

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_cg_UV",self)
	dt_cg_UV()

var tank_market_val:float = 0.75
var consumable_cost:float = 5.0

func dt_cg_UV():
	tank_market_val = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_ENCELADUS","tank_market_val")
	consumable_cost = pointersDT.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_ENCELADUS","consumable_cost")

func replaceShipWithFirstInGarage():
	if state.garage:
		shipMutex.lock()
		var firstShip = state.garage[0]
		state.garage.remove(0)
		state.ship = firstShip
		shipMutex.unlock()

func getMineralMarketPricePerKgAt(material, time):
	return .getMineralMarketPricePerKgAt(material, time) * tank_market_val

func getMineralMarketPricePerKg(material):
	var val = .getMineralMarketPricePerKg(material)
	match material:
		"AMMO","DRONES":
			return val * consumable_cost
	return val
