extends Control

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
