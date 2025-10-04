extends AnimatableBody3D

@onready var bubble: DialogBubble = $DialogBubble

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_char_entered() -> void:
	bubble.show()
	
func on_char_exited() -> void:
	bubble.hide()


func _on_interactive_area_body_entered(body: Node3D) -> void:
	if body is Player:
		on_char_entered()
	

func _on_interactive_area_body_exited(body: Node3D) -> void:
	if body is Player:
		on_char_exited()
