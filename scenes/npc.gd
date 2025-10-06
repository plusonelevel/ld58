extends AnimatableBody3D

@onready var bubble: DialogBubble = $DialogBubble

var active = false
var hovering = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.clue_drag_finished.connect(_on_clue_drag_finished)
	
	var player: AnimationPlayer = $Model/AnimationPlayer
	if player:
		player.play("Idle")
	
	#$Dummy.hide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and active and hovering:
			if bubble.active:
				bubble.next_line()
			else:
				bubble.activate()


func on_char_entered() -> void:
	active = true
	if can_display_dialogue():
		CursorManager.dialogue_enabled.emit()
	
func on_char_exited() -> void:
	bubble.deactivate()
	active = false
	CursorManager.dialogue_disabled.emit()


func _on_interactive_area_body_entered(body: Node3D) -> void:
	if body is Player:
		on_char_entered()

func _on_interactive_area_body_exited(body: Node3D) -> void:
	if body is Player:
		on_char_exited()


func _on_mouse_entered() -> void:
	hovering = true
	if can_display_dialogue():
		CursorManager.dialogue_enabled.emit()

func _on_mouse_exited() -> void:
	hovering = false
	CursorManager.dialogue_disabled.emit()


func _on_clue_drag_finished(clue: String):
	if active and hovering and Inventory.is_clue_known(clue):
		receive_input(clue)


func receive_input(input: String):
	Signals.journal_closed.emit()
	bubble.get_reaction(input)

func can_display_dialogue() -> bool:
	return active and hovering and (Inventory.dragged_item == null or Inventory.is_clue_known(Inventory.dragged_item))
