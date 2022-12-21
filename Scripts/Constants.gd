extends Node

## Constantes du jeu

const PLATEFORM_PATHS = [
	"res://Scenes/Plateforme/Plateforme-A.tscn",
	"res://Scenes/Plateforme/Plateforme-B.tscn",
	"res://Scenes/Plateforme/Plateforme-C.tscn",
]

const FLAG = preload("res://Scenes/Flag.tscn")
const MAIN_SCENE = "res://Scenes/Main.tscn"

## Limite inférieure des plateformes en X
const PLATFORM_MIN_X = 133
## Limite supérieure des plateformes en X
const PLATFORM_MAX_X = 888
## Nombre minimum de plateforme a atteindre avant de compter le score
const MIN_PLATFORM_TO_REACH = 3

const WALK_SPEED = 300

var plateforms_template = []

func _ready():
	for path in PLATEFORM_PATHS:
		plateforms_template.append(load(path))
