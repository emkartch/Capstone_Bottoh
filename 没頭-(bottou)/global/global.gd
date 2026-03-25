extends Node

# 0 is for before the first goal is shown, then moving to up allows for iteration in arrays
var level = 0

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
var open_passport = null

var notebook_appearance = null
var notebook_clothes = null
var notebook_colors = null
var notebook_hats = null
var note_questions = null

# Hold child nodes to keep information

# Make connect button work 

@onready var appearance = preload("res://inventory/pages/notebook/notebook_appearance.tscn")
@onready var clothes = preload("res://inventory/pages/notebook/notebook_clothes.tscn")
@onready var colors = preload("res://inventory/pages/notebook/notebook_colors.tscn")
@onready var hats = preload("res://inventory/pages/notebook/notebook_hats.tscn")

@onready var hud = get_node("/root/Main/HUD")
@onready var connect_button = get_node("/root/Main/HUD/InGame/ConnectButton")
@onready var notif = get_node("/root/Main/HUD/InGame/Notification")

var notebook_appearances_nodes = []
var notebook_clothing_1_nodes = []
var notebook_clothing_2_nodes = []
var notebook_hats_nodes = []
var notebook_color_nodes = []
var notebook_longhair_nodes = []
var notebook_shorthair_nodes = []

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

var appearance_filled = false
var clothes_1_filled = false
var clothes_2_filled = false
var hats_filled = false
var colors_filled = false
var long_hairs_filled = false
var short_hairs_filled = false

# Make connect button work 

# For pickable clicked

@onready var inventory_container = get_node("/root/Main/Inventory/InventoryContainer")
@onready var dialog = get_node("/root/Main/HUD/InGame/Dialog")

var run_show_popup = true

var visible_popup = false
var popup_ans = null

var popup_hover = false
var info_click = false
var select_click = false

var group_type = null
var select_group_type = null

var speaker = null
var text = null

# For pickable clicked

## Goal changes
#
#@onready var goal_text = get_node("/root/Main/HUD/InGame/Goal/GoalOpen/VBoxContainer/GoalText")
#
## Goal changes

var new_info = false

# Tutorials

var tutorial_1 = false
var tut_1_playing = false
var tutorial_2 = false
var tut_2_playing = false
var tutorial_3 = false
var tut_3_playing = false
var tutorial_4 = false
var tut_4_playing = false
var tutorial_5 = false
var tut_5_playing = false
var tutorial_6 = false
var tut_6_playing = false
var tutorial_7 = false
var tut_7_playing = false
var tutorial_8 = false
var tut_8_playing = false
var tutorial_9 = false
var tut_9_playing = false
var tutorial_10 = false
var tut_10_playing = false
var tutorial_11 = false
var tut_11_playing = false
var tutorial_12 = false
var tut_12_playing = false
var tutorial_13 = false
var tut_13_playing = false

# Tutorials

# Working Inventory Add

@onready var main = get_node("/root/Main")

var have_newspaper = false

var look_newspaper_passport = false

# Working Inventory Add

var notebook_filled = false

signal full_notebook

signal connect_show

signal translated_note

func _ready():
	
	# CUSTOM CURSOR
	Input.set_custom_mouse_cursor(cursor_normal, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(cursor_normal, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(cursor_point, Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(cursor_closed, Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(cursor_point, Input.CURSOR_POINTING_HAND)
	# CUSTOM CURSOR
	
	connect_button.pressed.connect(_on_connect_button_pressed)
	
	var slot_array = get_tree().get_nodes_in_group("slot")
	
	for slot in slot_array:
		
		if not slot.slot_clicked.is_connected(_on_slot_click):
		
			slot.slot_clicked.connect(_on_slot_click)
	
	notebook_appearance = appearance.instantiate()
		
	for child in notebook_appearance.get_children():
			
		if child is not HSeparator:
				
			if child.name == "Long Hair" or child.name == "Long Hair JPN":
				
				notebook_longhair_nodes.append(child)
				
			elif child.name == "Short Hair" or child.name == "Short Hair JPN":
				
				notebook_shorthair_nodes.append(child)
				
			elif child.name == "Tall" or child.name == "Short (Stature)" or child.name == "Tall JPN" or child.name == "Short (Stature) JPN":
				
				notebook_appearances_nodes.append(child)
		
	notebook_clothes = clothes.instantiate()
		
	for child in notebook_clothes.get_children():
		
		if child is not HSeparator:
			
			if child.name == "T-Shirt" or child.name == "T-Shirt JPN" or child.name == "Button Up Shirt" or child.name == "Button Up Shirt JPN":
				
				notebook_clothing_1_nodes.append(child)
				
			elif child.name == "Sweater" or child.name == "Sweater JPN" or child.name == "Jacket" or child.name == "Jacket JPN":
				
				notebook_clothing_2_nodes.append(child)
		
	notebook_colors = colors.instantiate()
		
	for child in notebook_colors.get_children():
		
		if child is not HSeparator:
			
			notebook_color_nodes.append(child)
		
	notebook_hats = hats.instantiate()
		
	for child in notebook_hats.get_children():
		
		if child is not HSeparator:
			
			notebook_hats_nodes.append(child)
	
	await hud.ready
	
	hud.show_start()

func _process(_delta):
	
	check_correct()
	
	var selected = get_tree().get_nodes_in_group("selected")
	
	if selected.size() == 2:
		
		if Global.level == 13 and not tutorial_13:
			
			emit_signal("connect_show")
		
		connect_button.visible = true
	else:
		connect_button.visible = false

func _input(event):
	
	if event is InputEventMouseButton and event.pressed:
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			
			if tut_1_playing and not tutorial_1:
				
				tutorial_1 = true
			
			elif tut_2_playing and not tutorial_2:
				
				tutorial_2 = true
				
			elif tut_3_playing and not tutorial_3:
				
				tutorial_3 = true
				
			elif tut_4_playing and not tutorial_4:
				
				tutorial_4 = true
				
			elif tut_5_playing and not tutorial_5:
				
				tutorial_5 = true
				
			elif tut_6_playing and not tutorial_6:
				
				tutorial_6 = true
				
			elif tut_7_playing and not tutorial_7:
				
				tutorial_7 = true
				
			elif tut_8_playing and not tutorial_8:
				
				tutorial_8 = true
				
			elif tut_9_playing and not tutorial_9:
				
				tutorial_9 = true
				
			elif tut_10_playing and not tutorial_10:
				
				tutorial_10 = true
				
			elif tut_11_playing and not tutorial_11:
				
				tutorial_11 = true
				
			elif tut_12_playing and not tutorial_12:
				
				tutorial_12 = true
				
			elif tut_13_playing and not tutorial_13:
				
				tutorial_13 = true
	
	elif event.is_action_pressed("ui_accept"):
		
		if tut_1_playing and not tutorial_1:
			
			tutorial_1 = true
		
		elif tut_2_playing and not tutorial_2:
			
			tutorial_2 = true
			
		elif tut_3_playing and not tutorial_3:
			
			tutorial_3 = true
			
		elif tut_4_playing and not tutorial_4:
			
			tutorial_4 = true
			
		elif tut_5_playing and not tutorial_5:
			
			tutorial_5 = true
			
		elif tut_6_playing and not tutorial_6:
			
			tutorial_6 = true
			
		elif tut_7_playing and not tutorial_7:
			
			tutorial_7 = true
			
		elif tut_8_playing and not tutorial_8:
			
			tutorial_8 = true
			
		elif tut_9_playing and not tutorial_9:
			
			tutorial_9 = true
			
		elif tut_10_playing and not tutorial_10:
			
			tutorial_10 = true
			
		elif tut_11_playing and not tutorial_11:
			
			tutorial_11 = true
			
		elif tut_12_playing and not tutorial_12:
			
			tutorial_12 = true
			
		elif tut_13_playing and not tutorial_13:
			
			tutorial_13 = true
	

func _on_connect_button_pressed() -> void:
	
	var selected = get_tree().get_nodes_in_group("selected")
		
	if selected[0].is_in_group("correct_looks") and selected[1].is_in_group("correct_looks"):
		
		notif.display_notif("Correct",60)
		looks_ans.modulate.a = 255
		looks_correct = true
		
	elif selected[0].is_in_group("correct_hair") and selected[1].is_in_group("correct_hair"):
		
		notif.display_notif("Correct",60)
		hair_ans.modulate.a = 255
		hair_correct = true
		
	elif selected[0].is_in_group("correct_color_clothes") and selected[1].is_in_group("correct_color_clothes"):
		
		notif.display_notif("Correct",60)
		clothes_color_ans.modulate.a = 255
		clothes_color_correct = true
		
	elif selected[0].is_in_group("correct_type_clothes") and selected[1].is_in_group("correct_type_clothes"):
		
		notif.display_notif("Correct",60)
		clothes_type_ans.modulate.a = 255
		clothes_type_correct = true
		
	elif selected[0].is_in_group("correct_hat") and selected[1].is_in_group("correct_hat"):
	
		notif.display_notif("Correct",60)
		hat_ans.modulate.a = 255
		hat_correct = true
	
	else:
		
		notif.display_notif("No Correlation",60)
		
	for select in selected:
		select.select_line.visible = false
		select.is_select = false
		select.remove_from_group("selected")
		
	connect_button.visible = false

func _on_pickable_click(node):
	
	#if not inventory_container.expand_state:
		#
		#if run_show_popup:
			#
			#run_show_popup = false
			#
			#show_popup()
			#
			#while popup_ans == null:
				#await get_tree().process_frame
			#
			#if popup_ans == "select":
				#
				#if clicked_node is Panel:
					#
					#if !clicked_node.inventory_open:
						#
						#_handle_select(clicked_node)
					#
				#else:
					#_handle_select(clicked_node)
				#
			#elif popup_ans == 'information':
				#
				#if not clicked_node.get_meta_list().is_empty():
					#
					#var item_data = clicked_node.get_meta('item_data')
					#
					#speaker = String(item_data.item_name) + " Information"
					#
					#text = String(item_data.description)
					#
				#else:
					#
					#speaker = String(clicked_node.item_name) + " Information"
					#
					#text = String(clicked_node.description)
				#
				#dialog.display_line(true,text,speaker)
				#
			#popup_ans = null
			#
			#run_show_popup = true
			#
	#else:
	#_handle_select(clicked_node)
	
	if node.is_in_group("question"):
		group_type = 'question'
	else:
		group_type = 'answer'
	
	if node.is_select:
		
		node.select_line.visible = false
		
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
					
					select.select_line.visible = false
					
					select.is_select = false
					select.remove_from_group("selected")
		
		node.add_to_group("selected")
		
		node.select_line.visible = true

		node.is_select = true
	
	group_type = null
	select_group_type = null

#func _handle_select(node):
	#
	#if node.is_in_group("question"):
		#group_type = 'question'
	#else:
		#group_type = 'answer'
	#
	#if node.is_select:
		#
		#node.select_line.visible = false
		##if node is Panel:
			##node.icon.material.set_shader_parameter("width",0)
			##node.icon.material.set_shader_parameter("color",Color.WHITE)
		##elif node.item == null:
			##node.select_line.visible = false
		##else:
			##node.object.material.set_shader_parameter("width",0)
			##node.object.material.set_shader_parameter("color",Color.WHITE)
		#
		#node.is_select = false
		#node.remove_from_group("selected")
		#
	#elif not node.is_select:
		#
		#var selected = get_tree().get_nodes_in_group("selected")
		#
		#if not selected.is_empty():
			#for select in selected:
				#if select.is_in_group("question"):
					#select_group_type = 'question'
				#else:
					#select_group_type = 'answer'
				#
				#if group_type == select_group_type:
					#
					#select.select_line.visible = false
					##if node is Panel:
						##select.icon.material.set_shader_parameter("width",0)
						##select.icon.material.set_shader_parameter("color",Color.WHITE)
					##elif node.item == null:
						##select.select_line.visible = false
					##else:
						##select.object.material.set_shader_parameter("width",0)
						##select.object.material.set_shader_parameter("color",Color.WHITE)
					#
					#select.is_select = false
					#select.remove_from_group("selected")
		#
		#node.add_to_group("selected")
		#
		#node.select_line.visible = true
		##if node is Panel:
			##node.icon.material.set_shader_parameter("width",5)
			##node.icon.material.set_shader_parameter("color",Color.GOLD)
		##elif node.item == null:
			##node.select_line.visible = true
		##else:
			##node.object.material.set_shader_parameter("width",10)
			##node.object.material.set_shader_parameter("color",Color.GOLD)
		#
		#
		#node.is_select = true
	#
	#group_type = null
	#select_group_type = null

func _on_interactable_click(node):
	
	#if tutorial_6 == false and level == 3:
		#
		#Global.tutorial_6 = true
	
	if node.item_name == "ClosedSignBS" or node.item_name == "ClosedSignHS" or node.item_name == "ClosedSignClS":
		
		if Global.level >= 12:
			
			if node.item_name == "ClosedSignBS":
				
				node.description = GameScript.speech_BS[0][1]
				
			elif node.item_name == "ClosedSignHS":
				
				node.description = GameScript.speech_HS[0][1]
				
			elif node.item_name == "ClosedSignClS":
				
				node.description = GameScript.speech_ClS[0][1]
				
		else:
			
			if node.item_name == "ClosedSignBS":
				
				node.description = GameScript.speech_BS[1][1]
				
			elif node.item_name == "ClosedSignHS":
				
				node.description = GameScript.speech_HS[1][1]
				
			elif node.item_name == "ClosedSignClS":
				
				node.description = GameScript.speech_ClS[1][1]
	
	dialog.display_line(true,false,"thought",node.description)
	
	await dialog.continue_true
	
	if node.item_name == "Newspaper" and not have_newspaper:
		
		for slot in inventory_container.get_node("ScrollContainer/VBoxInventory").get_children():
			
			if slot.item == null:
				
				slot.item = main.newspaper_ID
				
				have_newspaper = true
				
				break
	
	if node.item_name == "BookstoreBook":
		
		if not appearance_filled:
			
			new_info = true
			
			for item in notebook_appearances_nodes:
				
				item.modulate.a = 255
				
			appearance_filled = true
	
	elif node.item_name == "ClothingPoster1":
		
		if not clothes_1_filled:
			
			new_info = true
			
			for item in notebook_clothing_1_nodes:
				
				item.modulate.a = 255
			
			clothes_1_filled = true
	
	elif node.item_name == "ClothingPoster2":
		
		if not clothes_2_filled:
			
			new_info = true
			
			for item in notebook_clothing_2_nodes:
				
				item.modulate.a = 255
			
			clothes_2_filled = true
	
	elif node.item_name == "HatPoster":
		
		if not hats_filled:
			
			new_info = true
			
			for item in notebook_hats_nodes:
				
				item.modulate.a = 255
			
			hats_filled = true
	
	elif node.item_name == "ColorPamphlet":
		
		if not colors_filled:
			
			new_info = true
			
			for item in notebook_color_nodes:
					
				item.modulate.a = 255
			
			colors_filled = true
	
	elif node.item_name == "ShortHairPoster":
		
		if not short_hairs_filled:
			
			new_info = true
			
			for item in notebook_shorthair_nodes:
				
				item.modulate.a = 255
			
			short_hairs_filled = true
	
	elif node.item_name == "LongHairPoster":
		
		if not long_hairs_filled:
			
			new_info = true
			
			for item in notebook_longhair_nodes:
				
				item.modulate.a = 255
			
			long_hairs_filled = true
	
	if new_info:
		
		dialog.display_line(true,false,"thought","[i]This might be good information to add to my notebook.[/i]")
		
		await dialog.continue_true
		
		notif.display_notif("Notebook Updated",60)
		
		new_info = false

func _on_slot_click(node):
	
	dialog.display_line(true,false,"thought",node.item.description)

func check_correct():
	
	if appearance_filled and clothes_1_filled and clothes_2_filled and hats_filled and colors_filled and long_hairs_filled and short_hairs_filled:
		
		#level += 1
		#
		##goal_text.text = "Finish filling out the note using your notebook."
		#
		#hud.next_level_tutorial()
		
		notebook_filled = true
		
		if Global.level == 12:
			
			emit_signal("full_notebook")
	
	if looks_correct and hair_correct and clothes_color_correct and clothes_type_correct and hat_correct:
		#Global.game_end = true
		#hud.show_end()
		
		if Global.level == 13:
			
			emit_signal("translated_note")
