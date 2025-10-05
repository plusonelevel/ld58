extends AnimatableBody3D

@onready var bubble: DialogBubble = $DialogBubble
@onready var anim_tree := $AnimationTree

var active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player: AnimationPlayer = $Model/AnimationPlayer
	player.play("Sitting")
	$Dummy.hide()
	
func _input(event: InputEvent) -> void:
	if active and event.is_action_pressed("ui_accept"):
		bubble.next_line()

func on_char_entered() -> void:
	active = true
	bubble.activate()
	
func on_char_exited() -> void:
	bubble.deactivate()
	active = false


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


func _on_dialog_bubble_mouse_entered() -> void:
	pass # Replace with function body.


func _on_dialog_bubble_mouse_exited() -> void:
	pass # Replace with function body.
