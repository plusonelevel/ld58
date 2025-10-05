extends Node

var cursor = load("res://assets/2d/cursor.png")
var cursor_active = load("res://assets/2d/cursor_active.png")
var cursor_dialogue = load("res://assets/2d/cursor_dialogue.png")
var cursor_dialogue_active = load("res://assets/2d/cursor_dialogue_Active.png")


func _ready():
	Input.set_custom_mouse_cursor(cursor)

func _process(_float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_custom_mouse_cursor(cursor_active)
	else:
		Input.set_custom_mouse_cursor(cursor)
	


func _on_dude_mouse_entered() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_custom_mouse_cursor(cursor_dialogue_active)
	else:
		Input.set_custom_mouse_cursor(cursor_dialogue)
