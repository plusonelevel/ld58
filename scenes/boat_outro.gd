extends Node3D

@onready var boat = $"." 
var base_y := 0.0
var base_x := 0.0
var base_z := 0.0
var time := 0.0

func _ready() -> void:
	base_y = boat.position.y
	base_x = boat.position.x
	base_z = boat.position.z

func _process(delta: float) -> void:
	time += delta
	boat.position.y = base_y + sin(time * 2.0) * 0.1
	boat.position.x = base_x + time
	#boat.position.z = base_z + time
