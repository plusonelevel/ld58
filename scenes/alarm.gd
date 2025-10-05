extends Node3D

@onready var alarm_light1 = $SpotLight3D
@onready var alarm_light2 = $SpotLight3D2

func _process(delta: float) -> void:
	alarm_light1.rotation.y += 5*delta
	alarm_light2.rotation.y += 5*delta
