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

@onready var popup = get_node("/root/Main/HUD/PopUpMenu")
@onready var dialog = get_node("/root/Main/HUD/Dialog")

var visible_popup = false
var popup_ans = null

var popup_hover = false
var info_click = false
var select_click = false

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
	
	var pickable_array = get_tree().get_nodes_in_group("pickable")
	
	for pick in pickable_array:
		
		if not pick.clicked.is_connected(Global._on_pickable_click):
		
			pick.clicked.connect(Global._on_pickable_click)

func _process(_delta):
	
	check_correct()
	
	var selected = get_tree().get_nodes_in_group("selected")
	
	if selected.size() == 2:
		connect_button.visible = true
	else:
		connect_button.visible = false
	
	if visible_popup:
		
		if not popup_hover:
			
			popup.visible = false
			
			visible_popup = false
			
			popup_ans = "leave"
			
			#block_rect.visible = false
			#
			#detect_rect.visible = false
			
		elif info_click:
			
			popup.visible = false
			
			info_click = false
			
			visible_popup = false
			
			popup_ans =  "information"
			
			#block_rect.visible = false
			#
			#detect_rect.visible = false
			
		elif select_click:
			
			popup.visible = false
			
			select_click = false
			
			visible_popup = false
			
			popup_ans = "select"
			
			#block_rect.visible = false
			#
			#detect_rect.visible = false

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
	
	show_popup()
	
	while popup_ans == null:
		await get_tree().process_frame
	
	if popup_ans == "select":
		
		if clicked_node is Panel:
			
			if !clicked_node.inventory_open:
				
				_handle_select(clicked_node)
			
		else:
			_handle_select(clicked_node)
		
	elif popup_ans == 'information':
		
		var item_data = clicked_node.get_meta('item_data')
		
		var speaker = String(item_data.item_name) + " Information"
		
		var text = String(item_data.description)
		
		dialog.display_line(true,text,speaker)
		
	popup_ans = null

func _handle_select(node):
	
	if node.is_in_group("question"):
		group_type = 'question'
	else:
		group_type = 'answer'

	if node.is_select:
		
		#clicked_node.select_line.visible = false
		if node is Panel:
			node.icon.material.set_shader_parameter("width",0)
			node.icon.material.set_shader_parameter("color",Color.WHITE)
		elif node.item == null:
			node.select_line.visible = false
		else:
			node.object.material.set_shader_parameter("width",0)
			node.object.material.set_shader_parameter("color",Color.WHITE)
		
		node.is_select = false
		node.remove_from_group("selected")
		
	elif not node.is_select:
		
		var selected = get_tree().get_nodes_in_group("selected")
		
		if not selected.is_empty():
			for select in selected:
				if select.is_in_group("question"):
					select_group_type = 'question'
				else:
					select_group_type = 'answer'
				
				if group_type == select_group_type:
					
					#select.select_line.visible = false
					if node is Panel:
						select.icon.material.set_shader_parameter("width",0)
						select.icon.material.set_shader_parameter("color",Color.WHITE)
					elif node.item == null:
						select.select_line.visible = false
					else:
						select.object.material.set_shader_parameter("width",0)
						select.object.material.set_shader_parameter("color",Color.WHITE)
					
					select.is_select = false
					select.remove_from_group("selected")
		
		node.add_to_group("selected")
		
		#clicked_node.select_line.visible = true
		if node is Panel:
			node.icon.material.set_shader_parameter("width",5)
			node.icon.material.set_shader_parameter("color",Color.GOLD)
		elif node.item == null:
			node.select_line.visible = true
		else:
			node.object.material.set_shader_parameter("width",10)
			node.object.material.set_shader_parameter("color",Color.GOLD)
		
		
		node.is_select = true
	
	group_type = null
	select_group_type = null

func check_correct():
	
	if looks_correct and hair_correct and clothes_color_correct and clothes_type_correct and hat_correct:
		Global.game_end = true
		#hud.show_end()

func show_popup():
	
	#block_rect.visible = true
	
	#detect_rect.visible = true
	
	visible_popup = true
	
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	
	mouse_position.x -= 90
	
	mouse_position.y -= 90
	
	popup.position = mouse_position
	
	popup_hover = true
	
	popup.visible = true
