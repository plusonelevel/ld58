class_name JournalClue extends Label

func _ready() -> void:
	set_drag_forwarding(_on_drag_initiated, func(): pass, func(): pass)
	
	
func _on_drag_initiated(_pos: Vector2):
	#set_drag_preview(self.duplicate())
	Signals.journal_clue_picked.emit(text)
