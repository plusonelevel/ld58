extends Node
@warning_ignore_start("unused_signal")

# Drag and drop
signal clue_drag_initiated(clue: String)
signal clue_drag_finished(clue: String)

# Clues
signal clue_collected(clue: String)
signal journal_opened
signal journal_closed
signal journal_clue_picked(clue: String)

# Game
signal game_finished

@warning_ignore_restore("unused_signal")
