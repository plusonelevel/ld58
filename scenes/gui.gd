extends Node3D

@onready var book = $Book
@onready var book_area = $BookArea

var book_orig_pos: Vector3
var book_target: Vector3

var is_in_book_area = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	book_target = book.position
	book_orig_pos = book.position
	Signals.clue_drag_finished.connect(_on_drag_release)

func _on_drag_release(clue: String) -> void:
	if is_in_book_area:
		Inventory.add(clue)
		Signals.clue_collected.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not (book_target - book.position).is_zero_approx():
		book.position = lerp(book.position, book_target, 10 * delta)

func _on_book_area_mouse_entered() -> void:
	book_target = Vector3(book_orig_pos.x, book_orig_pos.y + 0.05, book_orig_pos.z)
	is_in_book_area = true

func _on_book_area_mouse_exited() -> void:
	book_target = book_orig_pos
	is_in_book_area = false
