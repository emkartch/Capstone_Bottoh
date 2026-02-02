extends CanvasLayer

@onready var main = get_node("/root/Main")

#@onready var startPanel = get_node("StartText/Control/PanelContainer")
#@onready var endPanel = get_node("EndText/Control/PanelContainer")
#
#var viewport_size = get_viewport().size

#func _ready():
	#

func show_start():
	$StartText.show()

func _on_button_pressed() -> void:
	$StartText.hide()

func show_end():
	$EndText.show()
	await get_tree().create_timer(3).timeout
	main.get_tree().quit()
