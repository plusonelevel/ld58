class_name DialogBubble
extends StaticBody3D

@export var lines: Array[String]
@onready var label = $Sprite3D/SubViewport/RichTextLabel

var lines_idx = -1
var clue: Variant

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	Signals.clue_collected.connect(_on_clue_collected)
	
	$Sprite3D.modulate.a = 0.0
	_set_next_line()
	show()

func _parse_text(sliced_text: Array[String], is_known_clue: bool) -> String:
	if not sliced_text.size() == 3:
		print_debug("ERROR PARSING DIALOG TEXT")
		print_debug(sliced_text)
		return "".join(sliced_text)
	
	var parsed_text = ("[color=%s]" % ("green" if is_known_clue else "red")).join([sliced_text[0], sliced_text[1]])
	parsed_text = "[/color]".join([parsed_text, sliced_text[2]])
	return parsed_text

func set_text(text: String) -> void:
	var slices = text.split("^")
	
	if slices.size() > 1:
		var is_known = Inventory.is_clue_known(slices[1])
		text = _parse_text(slices, is_known)
		clue = null if is_known else slices[1]
		
	label.text = text

func activate() -> void:
	$CollisionShape3D.disabled = false
	_fade_in()

func deactivate() -> void:
	$CollisionShape3D.disabled = true
	var tween = create_tween()
	_fade_out(tween)


func _fade_in(tween = create_tween()) -> void:
	tween.tween_property($Sprite3D, "modulate:a", 1.0, 0.5)

func _fade_out(tween = create_tween()) -> void:
	tween.tween_property($Sprite3D, "modulate:a", 0.0, 0.5)

func _set_next_line(tween = create_tween()) -> void:
	tween.tween_callback(func ():
		lines_idx += 1
		set_text(lines[lines_idx])
	)

func next_line() -> void:
	if lines_idx < lines.size() - 1:
		var tween = create_tween()
		_fade_out(tween)
		_set_next_line(tween)
		_fade_in(tween)


func _on_clue_collected():
	# Re-parse current line
	set_text(lines[lines_idx])
