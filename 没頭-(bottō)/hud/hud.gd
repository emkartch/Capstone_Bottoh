extends CanvasLayer

@onready var main = get_node("/root/Main")
@onready var dialog = $Dialog

func show_start():
	#$StartEndPuzzleText.show()
	dialog.display_line(true,"Using your notepad (on the right) by flipping through the pages using the arrows on screen to match the Japanese characters on the right to their meaning on the left. To do this, click on the Japanese on the left, click the matching English meaning on the right, then press submit.","Tutorial")

func _on_button_pressed() -> void:
	$StartEndPuzzleText.hide()

func show_end():
	dialog.display_line("You did it!","Tutorial")
