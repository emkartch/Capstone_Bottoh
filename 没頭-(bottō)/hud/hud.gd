extends CanvasLayer

@onready var main = get_node("/root/Main")
@onready var dialog = $Dialog

@onready var goal_button = $Goal/GoalButton
@onready var goal_open = $Goal/GoalOpen

func show_start():
	dialog.display_line(true,"Using your notepad (on the right) by flipping through the pages using the arrows on screen to match the Japanese characters on the right to their meaning on the left. To do this, click on the Japanese on the left, click the matching English meaning on the right, then press submit.","Tutorial")

func show_end():
	dialog.display_line("You did it!","Tutorial")

func _on_goal_button_pressed() -> void:
	
	goal_button.visible = false
	goal_open.visible = true

func _on_exit_goal_button_pressed() -> void:
	
	goal_open.visible = false
	goal_button.visible = true
