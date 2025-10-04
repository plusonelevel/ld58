class_name DialogBubble
extends Node3D

@export var text: String
@onready var label = $Sprite3D/Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
