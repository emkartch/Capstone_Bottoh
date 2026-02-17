extends PanelContainer

class_name Door

@export var current_level_tag: String
@export var destination_level_tag: String
#@export var destination_door_tag: String

func _on_button_pressed() -> void:
	NavigationManager.go_to_level(current_level_tag,destination_level_tag)
