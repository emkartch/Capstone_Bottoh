extends Node

var notepad_page = 1

var main_pause = false

var game_end = false

const cursor_normal = preload("res://assets/CursorArrow.png")
const cursor_point = preload("res://assets/CursorHand.png")
const cursor_closed = preload("res://assets/CursorHandClosed.png")

# Hold child nodes to keep information

var open_newspaper = null
var open_new_map = null
var open_note = null
var open_notebook = null
var open_old_map = null

var notebook_appearance = null
var notebook_clothes = null
var notebook_colors = null
var notebook_hats = null
var note_questions = null

# Hold child nodes to keep information

# Make connect button work 

@onready var connect_button = get_node("/root/Main/HUD/ConnectButton")
@onready var notif = get_node("/root/Main/HUD/Notification")

var looks_ans = null
var hair_ans = null
var clothes_color_ans = null
var clothes_type_ans = null
var hat_ans = null

var looks_correct = false
var hair_correct = false
var clothes_color_correct = false
var clothes_type_correct = false
var hat_correct = false

# Make connect button work 

# For pickable clicked

var group_type = null
var select_group_type = null

# For pickable clicked

func _ready():
	
	# CUSTOM CURSOR
	Input.set_custom_mouse_cursor(cursor_normal, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(cursor_normal, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(cursor_point, Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(cursor_closed, Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(cursor_point, Input.CURSOR_POINTING_HAND)
	# CUSTOM CURSOR
	
	connect_button.pressed.connect(_on_connect_button_pressed)

func _process(_delta):
	
	var selected = get_tree().get_nodes_in_group("selected")
	
	if selected.size() == 2:
		connect_button.visible = true
	else:
		connect_button.visible = false

func _on_connect_button_pressed() -> void:
	
	var selected = get_tree().get_nodes_in_group("selected")
	
	if selected[0].is_in_group("correct_looks") and selected[1].is_in_group("correct_looks"):
		
		notif.display_notif("Correct")
		looks_ans.modulate.a = 255
		looks_correct = true
		
	elif selected[0].is_in_group("correct_hair") and selected[1].is_in_group("correct_hair"):
		
		notif.display_notif("Correct")
		hair_ans.modulate.a = 255
		hair_correct = true
		
	elif selected[0].is_in_group("correct_color_clothes") and selected[1].is_in_group("correct_color_clothes"):
		
		notif.display_notif("Correct")
		clothes_color_ans.modulate.a = 255
		clothes_color_correct = true
		
	elif selected[0].is_in_group("correct_type_clothes") and selected[1].is_in_group("correct_type_clothes"):
		
		notif.display_notif("Correct")
		clothes_type_ans.modulate.a = 255
		clothes_type_correct = true
		
	elif selected[0].is_in_group("correct_hat") and selected[1].is_in_group("correct_hat"):
		
		notif.display_notif("Correct")
		hat_ans.modulate.a = 255
		hat_correct = true
		
	else:
		
		notif.display_notif("Incorrect")
		
	for select in selected:
		select.select_line.visible = false
		select.is_select = false
		select.remove_from_group("selected")
		
	connect_button.visible = false

func _on_pickable_click(clicked_node):
	
	if clicked_node.is_in_group("question"):
		group_type = 'question'
	else:
		group_type = 'answer'

	if clicked_node.is_select:
		
		#clicked_node.select_line.visible = false
		if clicked_node.item == null:
			clicked_node.select_line.visible = false
		else:
			clicked_node.object.material.set_shader_parameter("width",0)
			clicked_node.object.material.set_shader_parameter("color",Color.WHITE)
		
		clicked_node.is_select = false
		clicked_node.remove_from_group("selected")
		
	elif not clicked_node.is_select:

		var selected = get_tree().get_nodes_in_group("selected")
		
		if not selected.is_empty():
			for select in selected:
				if select.is_in_group("question"):
					select_group_type = 'question'
				else:
					select_group_type = 'answer'
				
				if group_type == select_group_type:
					
					#select.select_line.visible = false
					if clicked_node.item == null:
						select.select_line.visible = false
					else:
						clicked_node.object.material.set_shader_parameter("width",0)
						clicked_node.object.material.set_shader_parameter("color",Color.WHITE)
					
					select.is_select = false
					select.remove_from_group("selected")
		
		clicked_node.add_to_group("selected")
		
		#clicked_node.select_line.visible = true
		if clicked_node.item == null:
			clicked_node.select_line.visible = true
		else:
			clicked_node.object.material.set_shader_parameter("width",10)
			clicked_node.object.material.set_shader_parameter("color",Color.GOLD)
		
		
		clicked_node.is_select = true
	
	group_type = null
	select_group_type = null
