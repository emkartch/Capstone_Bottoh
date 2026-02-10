extends CanvasLayer

@onready var main = get_node("/root/Main")
@onready var dialog = $Dialog

@onready var goal_button = $Goal/GoalButton
@onready var goal_open = $Goal/GoalOpen

func show_start():
	dialog.display_line(true,"Use your notepad (on the right) and flip through the pages using the arrows on screen to match the English defintions to the Japanese characters on the left. To do this, select both the Japanese on the left and its matching English meaning on the right, then press submit.","Tutorial")

func show_end():
	dialog.display_line(true,"You did it!","Tutorial")

func _on_goal_button_pressed() -> void:
	
	goal_button.visible = false
	goal_open.visible = true

func _on_exit_goal_button_pressed() -> void:
	
	goal_open.visible = false
	goal_button.visible = true
