extends Node3D

@onready var book = $Book
@onready var book_area = $BookArea

var book_orig_pos: Vector3
var book_target: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	book_target = book.position
	book_orig_pos = book.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not (book_target - book.position).is_zero_approx():
		book.position = lerp(book.position, book_target, 10 * delta)

func _on_book_area_mouse_entered() -> void:
	book_target = Vector3(book_orig_pos.x, book_orig_pos.y + 0.05, book_orig_pos.z)

func _on_book_area_mouse_exited() -> void:
	book_target = book_orig_pos
