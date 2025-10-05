extends Node3D

@onready var book = $Book
@onready var book_area = $BookArea
@onready var opened_book = $OpenedBook

var book_orig_pos: Vector3
var book_target_pos: Vector3
var book_orig_rot: Vector3
var book_target_rot: Vector3

var is_in_book_area = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	book_orig_pos = book.position
	book_target_pos = book.position
	
	book_orig_rot = book.rotation
	book_target_rot = book.rotation
	
	Signals.clue_drag_finished.connect(_on_clue_drag_finished)
	Signals.journal_closed.connect(_on_journal_closed)

func _on_clue_drag_finished(clue: String) -> void:
	if is_in_book_area:
		Inventory.add(clue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not (book_target_pos - book.position).is_zero_approx():
		book.position = lerp(book.position, book_target_pos, 10 * delta)
		book.rotation = lerp(book.rotation, book_target_rot, 10 * delta)

func _on_book_area_mouse_entered() -> void:
	book_target_pos = Vector3(book_orig_pos.x, book_orig_pos.y + 0.05, book_orig_pos.z)
	book_target_rot = Vector3(book_orig_rot.x, book_orig_rot.y - deg_to_rad(10), book_orig_rot.z)
	is_in_book_area = true

func _on_book_area_mouse_exited() -> void:
	book_target_pos = book_orig_pos
	book_target_rot = book_orig_rot
	is_in_book_area = false


func _on_book_area_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			Signals.journal_opened.emit()
			book.hide()
			opened_book.show()

func _on_journal_closed():
	book.show()
	opened_book.hide()
