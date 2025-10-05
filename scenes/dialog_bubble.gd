class_name DialogBubble
extends StaticBody3D

@export var lines: Array[String]
@onready var label = $Sprite3D/SubViewport/RichTextLabel

var lines_idx = -1
var clue: String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	$Sprite3D.transparency = 1.0
	set_next_line()

func _parse_text(sliced_text: Array[String]) -> String:
	if not sliced_text.size() == 3:
		print_debug("ERROR PARSING DIALOG TEXT")
		print_debug(sliced_text)
		return "".join(sliced_text)
		
	var is_known_clue = false
	var parsed_text = ("[color=%s]" % ("green" if is_known_clue else "red")).join([sliced_text[0], sliced_text[1]])
	parsed_text = "[/color]".join([parsed_text, sliced_text[2]])
	return parsed_text

func set_text(text: String) -> void:
	var slices = text.split("^")
	
	if slices.size() > 1:
		clue = slices[1]
		text = _parse_text(slices)
		
	label.text = text

func fade_in(tween = create_tween()) -> void:
	tween.tween_property($Sprite3D, "transparency", 0.0, 0.5)
	
func fade_out(tween = create_tween()) -> void:
	tween.tween_property($Sprite3D, "transparency", 1.0, 0.5)

func set_next_line(tween = create_tween()) -> void:
	tween.tween_callback(func ():
		lines_idx += 1
		set_text(lines[lines_idx])
	)

func next_line() -> void:
	if lines_idx < lines.size() - 1:
		var tween = create_tween()
		fade_out(tween)
		set_next_line(tween)
		fade_in(tween)
