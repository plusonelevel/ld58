extends Node

signal dialogue_enabled
signal dialogue_disabled

class CursorOptions:
	var default: Resource
	var active: Resource
	func _init(def: Resource, act: Resource):
		default = def
		active = act

var cursor_default = CursorOptions.new(
	load("res://assets/2d/cursor.png"),
	load("res://assets/2d/cursor_active.png")
)

var cursor_dialogue = CursorOptions.new(
	load("res://assets/2d/cursor_dialogue.png"),
	load("res://assets/2d/cursor_dialogue_Active.png")
)

var cursor: CursorOptions

var click_timer: Timer

func set_default():
	Input.set_custom_mouse_cursor(cursor.default)

func set_active():
	Input.set_custom_mouse_cursor(cursor.active)


func _init():
	dialogue_enabled.connect(_on_dialogue_enabled)
	dialogue_disabled.connect(_on_dialogue_disabled)
	

func _ready():
	cursor = cursor_default
	set_default()
	
	click_timer = get_node("/root/Main/CursorClickTimer")
	click_timer.timeout.connect(set_default)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			click_timer.stop()
			set_active()
		else:
			# Have to reset the connection otherwise the old cursor value is gonna be used for some reason
			click_timer.timeout.disconnect(set_default)
			click_timer.timeout.connect(set_default)
			click_timer.start()
			


func _on_dialogue_enabled() -> void:
	cursor = cursor_dialogue
	set_default()

func _on_dialogue_disabled() -> void:
	cursor = cursor_default
	set_default()
