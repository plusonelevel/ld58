extends Node


@onready var sfx_journal_open = $journal_open
@onready var sfx_journal_close = $journal_close
@onready var sfx_clue_drag = $clue_drag
@onready var sfx_clue_drop = $clue_drop


func _ready() -> void:
	Signals.journal_opened.connect(_on_journal_opened)
	Signals.journal_closed.connect(_on_journal_closed)
	Signals.clue_drag_initiated.connect(_on_clue_drag)
	Signals.clue_collected.connect(_on_clue_drop)
	
func _on_journal_opened():
	sfx_journal_open.play()

func _on_journal_closed():
	sfx_journal_close.play()
	
func _on_clue_drag():
	sfx_clue_drag.play()
	
func _on_clue_drop():
	sfx_clue_drop.play()
