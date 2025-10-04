extends Node3D

@onready var book = $Book
@onready var book_area = $BookArea

var book_target: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	book_target = book.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not (book_target - book.position).is_zero_approx():
		book.position = lerp(book.position, book_target, 10 * delta)

func _on_book_area_mouse_entered() -> void:
	book_target = book.position
	book_target.y += 0.05

func _on_book_area_mouse_exited() -> void:
	book_target = book.position
	book_target.y -= 0.05
