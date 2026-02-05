extends CanvasLayer

@onready var main = get_node("/root/Main")

func show_start():
	$StartEndPuzzleText.show()

func _on_button_pressed() -> void:
	$StartEndPuzzleText.hide()

func show_end():
	$EndText.show()
	await get_tree().create_timer(3).timeout
	main.get_tree().quit()
