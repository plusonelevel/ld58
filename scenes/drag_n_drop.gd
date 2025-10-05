extends Node3D

@onready var dragged_clue_label := $DraggedClue
@export var camera : Camera3D

var dragged_value: Variant

const LAYERS = {
	"world": 0b00000001,
	"player": 0b00000100,
	"npcs": 0b00001000,
	"interactive_text": 0b01000000,
	"ground": 0b10000000,
}
const RAYCAST_LENGTH = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dragged_clue_label.hide()


func _process(_delta) -> void:
	if dragged_value:
		handle_drag()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				handle_click()
			elif dragged_value:
				stop_drag()


func handle_click() -> void:
	var target = _get_click_collider()
	if target and target is DialogBubble:
		if target.clue:
			dragged_clue_label.position = target.position
			start_drag(target.clue)


func start_drag(clue: String) -> void:
	dragged_clue_label.text = clue
	dragged_clue_label.show()
	dragged_value = clue


func handle_drag():
	var drag_target = _get_mouse_target(LAYERS["ground"])
	if not drag_target.is_empty():
		dragged_clue_label.position.x = drag_target.position.x
		dragged_clue_label.position.z = drag_target.position.z


func _get_mouse_target(mask: int):
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()

	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * RAYCAST_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	query.collision_mask = mask

	return space_state.intersect_ray(query)


func _get_click_collider():
	var click_target = _get_mouse_target(LAYERS["interactive_text"])
	if not click_target.is_empty():
		return click_target.collider
	return null


func stop_drag():
	Signals.clue_drag_finished.emit(dragged_value)
	dragged_clue_label.hide()
	dragged_value = null
