extends Control

@onready var clues_container = $Clues

var clue_scene = preload("res://scenes/journal_clue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.journal_opened.connect(_on_journal_opened)
	Signals.journal_closed.connect(_on_journal_closed)
	Signals.clue_collected.connect(_on_clue_collected)
	
	hide()

func _on_journal_opened():
	show()


func _on_close_pressed() -> void:
	Signals.journal_closed.emit()


func _on_journal_closed():
	hide()


func _on_clue_collected() -> void:
	for c in clues_container.get_children():
		c.queue_free()
	for clue in Inventory.inventory:
		var jc: JournalClue = clue_scene.instantiate()
		jc.text = clue
		clues_container.add_child(jc)
