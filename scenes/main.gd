extends Node

@onready var camera = $World/Player/CameraTarget/Camera3D

func _ready() -> void:
	$DragNDrop.camera = camera
	Signals.journal_opened.connect(_on_journal_opened)

func _on_journal_opened():
	print_debug("JOURNAL OPENED")
