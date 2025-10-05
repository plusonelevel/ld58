extends Node3D

@onready var journal = $MeshInstance3D/journal
@onready var journal_open = $MeshInstance3D/journal2

func _ready() -> void:
	Signals.connect("journal_opened", _on_journal_opened)

func _on_journal_opened():
	journal.hide()
	journal_open.show()
