extends CanvasLayer

@onready var main = get_node("/root/Main")
@onready var dialog = $Dialog

@onready var goal_button = $Goal/GoalButton
@onready var goal_open = $Goal/GoalOpen
@onready var tutorial_button = $Tutorial

#@onready var popup_menu = preload("res://hud/pop_up_menu.tscn")

func show_start():
	
	tutorial_button.visible = false
	
	dialog.display_line(true,false,"Search the area to find information that will fill out the notebook in your inventory.","Tutorial")
	
	await dialog.continue_true
	
	dialog.display_line(true,false,"You can open your inventory by selecting the icon in the lower left corner.","Tutorial")
	
	await dialog.continue_true
	
	dialog.display_line(true,false,"To add information to your notebook, select the notebook in your inventory and an object in the world, then press the connect button that will appear.","Tutorial")
	
	await dialog.continue_true
	
	dialog.display_line(true,false,"You can check your progress by opening your inventory, selecting the expand button at the top right of your inventory, then dragging your notebook to the center of the screen.","Tutorial")
	
	await dialog.continue_true
	
	tutorial_button.visible = true

func show_end():
	tutorial_button.visible = false
	
	dialog.display_line(true,false,"You did it!","Tutorial")

func next_level_tutorial():
	
	tutorial_button.visible = false
	
	dialog.display_line(true,false,"Now we have to figure out the English meanings of the information found on the note in your inventory.","Tutorial")
	
	await dialog.continue_true
	
	dialog.display_line(true,false,"To do this, open your notebook and note in your expanded inventory by selecting the expand button at the top right of your inventory, then dragging your notebook and your note to the center of the screen.","Tutorial")
	
	await dialog.continue_true
	
	dialog.display_line(true,false,"Use your notebook and flip through the pages using the arrows on screen to match the English defintions to the Japanese characters.","Tutorial")
	
	await dialog.continue_true
	
	tutorial_button.visible = true

func _on_goal_button_pressed() -> void:
	
	goal_button.visible = false
	goal_open.visible = true

func _on_exit_goal_button_pressed() -> void:
	
	goal_open.visible = false
	goal_button.visible = true

func _on_tutorial_pressed() -> void:
	
	if Global.level == 1:
		show_start()
	elif Global.level ==2:
		next_level_tutorial()
