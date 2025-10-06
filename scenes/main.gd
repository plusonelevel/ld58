extends Node

@onready var camera = $World/Player/CameraTarget/Camera3D

func _ready() -> void:
	Signals.game_finished.connect(_on_game_finished)
	$DragNDrop.camera = camera

func _on_game_finished():
	get_tree().quit()
