extends Node

@onready var camera = $World/Player/CameraTarget/Camera3D

func _ready() -> void:
	$DragNDrop.camera = camera
