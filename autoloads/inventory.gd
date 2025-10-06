extends Node

var dragged_item: Variant
var inventory: Array[String]

func _init(): 
	inventory = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func add(clue: String) -> void:
	if not is_clue_known(clue):
		inventory.append(clue)
		Signals.clue_collected.emit()


func is_clue_known(clue: String) -> bool:
	return inventory.has(clue)
