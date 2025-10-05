extends Node

# Drag and drop
signal clue_drag_initiated(clue: String)
signal clue_drag_finished(clue: String)

# Clues
signal clue_collected(clue: String)
signal journal_opened
signal journal_closed
