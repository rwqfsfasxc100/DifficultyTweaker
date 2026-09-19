extends "res://story/SingularityCore.gd"

var base_repel_strength = - 1024
var base_attract_strength = 1024

var base_repel_width = 500
var base_repel_height = 800
var base_attract_width = 2000
var base_attract_height = 4000

onready var attract_area_shape = $Attractor/CollisionShape2D
onready var repel_area_shape = $Repellant/CollisionShape2D

var pointersDT:HevLibPointers._ConfigDriver

func _ready():
	pointersDT = ModLoader._savedObjects[0].ConfigDriver
	pointersDT.__establish_connection("dt_singularity_UV",self)
	dt_singularity_UV()
	
	
	base_repel_strength = repel.gravity
	base_attract_strength = attract.gravity
	base_repel_width = repel_area_shape.shape.radius
	base_repel_height = repel_area_shape.shape.height
	base_attract_width = attract_area_shape.shape.radius
	base_attract_height = attract_area_shape.shape.height

func dt_singularity_UV():
	var cfg = pointersDT.__get_config("DifficultyTweaker").get("DIFFTWEAK_CONFIG_SECT_ODDITIES",{})
	if cfg.get("invert_singularity_repulsion",false):
		repel.gravity = -base_repel_strength
	else:
		repel.gravity = base_repel_strength
	if cfg.get("invert_singularity_attraction",false):
		attract.gravity = -base_attract_strength
	else:
		attract.gravity = base_attract_strength
	attract.gravity = attract.gravity * cfg.get("singularity_attraction_strength_multiplier",2.5)
	repel.gravity = repel.gravity * cfg.get("singularity_repel_strength_multiplier",2.5)
	
	repel_area_shape.shape.radius = base_repel_width * cfg.get("singularity_repel_size_multiplier",2.5)
	repel_area_shape.shape.height = base_repel_height * cfg.get("singularity_repel_size_multiplier",2.5)
	attract_area_shape.shape.radius = base_attract_width * cfg.get("singularity_attract_size_multiplier",2.5)
	attract_area_shape.shape.height = base_attract_height * cfg.get("singularity_attract_size_multiplier",2.5)
	
	
