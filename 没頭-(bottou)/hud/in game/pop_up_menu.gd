extends Control

func _on_information_pressed() -> void:
	Global.info_click = true

func _on_select_pressed() -> void:
	Global.select_click = true

func _on_mouse_exited() -> void:
	Global.popup_hover = false
