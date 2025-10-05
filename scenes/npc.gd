extends AnimatableBody3D

@onready var bubble: DialogBubble = $DialogBubble

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		bubble.next_line()

func on_char_entered() -> void:
	bubble.fade_in()
	
func on_char_exited() -> void:
	bubble.fade_out()


func _on_interactive_area_body_entered(body: Node3D) -> void:
	if body is Player:
		on_char_entered()
	

func _on_interactive_area_body_exited(body: Node3D) -> void:
	if body is Player:
		on_char_exited()


func _on_mouse_entered() -> void:
	CursorManager.dialogue_enabled.emit()


func _on_mouse_exited() -> void:
	CursorManager.dialogue_disabled.emit()
