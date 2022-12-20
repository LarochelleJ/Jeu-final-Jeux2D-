extends Node

const PLATEFORM_PATHS = [
	"res://Scenes/Plateforme/Plateforme-A.tscn",
	"res://Scenes/Plateforme/Plateforme-B.tscn",
	"res://Scenes/Plateforme/Plateforme-C.tscn",
]

const FLAG = preload("res://Scenes/Flag.tscn")
const PLATFORM_MIN_X = 133
const PLATFORM_MAX_X = 888

var plateforms_template = []

func _ready():
	for path in PLATEFORM_PATHS:
		plateforms_template.append(load(path))
