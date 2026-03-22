extends PanelContainer

class_name Door

@export var current_level_tag: String
@export var destination_level_tag: String
#@export var destination_door_tag: String

@onready var door_texture = preload("res://areas/DoorOpen.png")
@onready var button = $Button
@onready var dialog = get_node("/root/Main/HUD/InGame/Dialog")

func _on_button_pressed() -> void:
	
	if Global.level == 0:
		
		if self.name == "Door_CSO" or self.name == "Door_BO" or self.name == "Door_HSO" or self.name == "Door_BSO" or self.name == "Door_SSO" or self.name == "Door_ClSO" or self.name == "Door_SV1_L" or self.name == "Door_SV2_L":
		
			dialog.display_line(true,false,"thought","I don't have time to look around.","")
		
		elif self.name == "Door_SV2_R" and Global.tutorial_1 == false:
		
			Global.tutorial_1 = true
			
			NavigationManager.go_to_level(current_level_tag,destination_level_tag)
		
		else:
			
			NavigationManager.go_to_level(current_level_tag,destination_level_tag)
	else:
		NavigationManager.go_to_level(current_level_tag,destination_level_tag)

func _on_button_mouse_entered() -> void:
	
	if button.texture_normal == door_texture:
		
		self.position.x = 880

func _on_button_mouse_exited() -> void:
	
	if button.texture_normal == door_texture:
		
		self.position.x = 930
