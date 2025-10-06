extends Control

@onready var tutorial = $Tutorial

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if self.visible:
			self.hide()
		else:
			self.show()


func _on_continue_pressed() -> void:
	self.hide()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_close_pressed() -> void:
	tutorial.hide()


func _on_how_to_play_pressed() -> void:
	tutorial.show()
