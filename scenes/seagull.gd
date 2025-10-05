extends Node3D

func _ready():
	pass

func _physics_process(delta: float) -> void:
	$"..".progress += 6.0 * delta
