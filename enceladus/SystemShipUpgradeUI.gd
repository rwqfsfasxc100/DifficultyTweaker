extends "res://enceladus/SystemShipUpgradeUI.gd"

var pointersDT:HevLibPointers = ModLoader._savedObjects[0]

func _ready():
	pointersDT.ConfigDriver.__establish_connection("dt_lossytradein_UV",self)
	dt_lossytradein_UV()

var lossy_val_multi:float = 0.9

func dt_lossytradein_UV():
	lossy_val_multi = 1.0 - pointersDT.ConfigDriver.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_ENCELADUS","equipment_trade_in_fees")

func getNetPrice():
	var act = actualReplacementValue
	var dis = discount
	if act > 0:
		actualReplacementValue *= lossy_val_multi
	if dis > 0:
		discount *= lossy_val_multi
	var val = .getNetPrice()
	actualReplacementValue = act
	discount = dis
	return val
