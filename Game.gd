extends "res://Game.gd"

func gameOverScreen():
	if ModLoader._savedObjects[0].ConfigDriver.__get_value("DifficultyTweaker","DIFFTWEAK_CONFIG_SECT_SHIPS","permanently_lose_ships") and CurrentGame.state.garage:
		CurrentGame.replaceShipWithFirstInGarage()
		goToEnceladus()
	else:
		.gameOverScreen()
