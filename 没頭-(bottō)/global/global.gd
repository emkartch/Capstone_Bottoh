extends Node

#@onready var hud = get_node("/root/HUD")

var notepad_page = 1

var main_pause = false

var game_end = false

const cursor_normal = preload("res://assets/CursorArrow.png")
const cursor_point = preload("res://assets/CursorHand.png")
const cursor_closed = preload("res://assets/CursorHandClosed.png")

func _ready():
	
	# CUSTOM CURSOR
	Input.set_custom_mouse_cursor(cursor_normal, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(cursor_normal, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(cursor_point, Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(cursor_closed, Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(cursor_point, Input.CURSOR_POINTING_HAND)
	# CUSTOM CURSOR
