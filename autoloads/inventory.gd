extends Node

var inventory: Array[String]

func _init(): 
	inventory = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func add(clue: String) -> void:
	inventory.append(clue)


func is_clue_known(clue: String) -> bool:
	return inventory.has(clue)
