extends PanelContainer

class_name Door

@export var current_level_tag: String
@export var destination_level_tag: String
#@export var destination_door_tag: String

@onready var door_texture = preload("res://areas/DoorOpen.png")
@onready var button = $Button

func _on_button_pressed() -> void:
	
	NavigationManager.go_to_level(current_level_tag,destination_level_tag)

func _on_button_mouse_entered() -> void:
	
	if button.texture_normal == door_texture:
		
		self.position.x = 880

func _on_button_mouse_exited() -> void:
	
	if button.texture_normal == door_texture:
		
		self.position.x = 930
