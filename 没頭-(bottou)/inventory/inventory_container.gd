extends TextureRect

# Created with the help of Kilo Galaxia - https://www.youtube.com/watch?v=dHPCizHygWA

@onready var scroll_container = $ScrollContainer
@onready var up_arrow = $UpArrow
@onready var down_arrow = $DownArrow
@onready var bag_button = $"../MessangerBag"
@onready var expand_button = $ExpandButton
@onready var inventory_open = $"../InventoryOpen"
@onready var hbox_inventory = $"../InventoryOpen/HBoxInventory"
@onready var background_blur = $"../BackgroundBlur"

var open_texture = preload("res://inventory/MessangerbagOpen.png")
var closed_texture = preload("res://inventory/MessangerbagClosed.png")
var expand_texture = preload("res://inventory/Expandbutton.png")
var minimize_texture = preload("res://inventory/MinimizeButton.png")

var pickable_array = null
var question_array = null
var answer_array = null

var state = false
var expand_state = false

var hbox_size = null

func _ready():
	
	up_arrow.disabled = true
	
	hbox_size = 1526 #hbox_inventory.size.x
	
	#connect_button.pressed.connect(_on_connect_button_pressed)

func _process(_delta):
	
	var value = scroll_container.get_v_scroll()
	
	if value == 0:
		up_arrow.disabled = true
		up_arrow.mouse_default_cursor_shape = Control.CURSOR_ARROW
	else:
		up_arrow.disabled = false
		up_arrow.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	if value == 320:
		down_arrow.disabled = true
		down_arrow.mouse_default_cursor_shape = Control.CURSOR_ARROW
	else:
		down_arrow.disabled = false
		down_arrow.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _on_up_arrow_pressed() -> void:
	var value = scroll_container.get_v_scroll()
	
	var final_value = value - 160
	
	if final_value < 0:
		final_value = 0
	
	scroll_container.set_v_scroll(final_value)

func _on_down_arrow_pressed() -> void:
	var value = scroll_container.get_v_scroll()
	
	var final_value = value + 160
	
	if final_value > 480:
		final_value = 480

	scroll_container.set_v_scroll(final_value)

func _on_messanger_bag_pressed() -> void:
	
	if not Global.tutorial_7 and Global.level == 3:
		
		Global.tutorial_7 = true
	
	if state:
		bag_button.set_button_icon(closed_texture)
		state = false
		self.visible = false
		var selected = get_tree().get_nodes_in_group("selected")
		if not selected.is_empty():
			for select in selected:
				
				if select is Panel:
					select.icon.material.set_shader_parameter("width",0)
					select.icon.material.set_shader_parameter("color",Color.WHITE)
				elif select.item == null:
					select.select_line.visible = false
				else:
					select.object.material.set_shader_parameter("width",0)
					select.object.material.set_shader_parameter("color",Color.WHITE)
				select.is_select = false
				select.remove_from_group("selected")
				
	elif not state:
		bag_button.set_button_icon(open_texture)
		state = true
		self.visible = true

func _on_expand_button_pressed() -> void:
	
	if not Global.tutorial_8 and Global.level == 3:
		
		Global.tutorial_8 = true
	
	if expand_state:
		self.anchor_top = 0.34
		self.anchor_bottom = 0.81
		expand_button.set_button_icon(expand_texture)
		expand_state = false
		bag_button.visible = true
		up_arrow.visible = true
		down_arrow.visible = true
		inventory_open.mouse_filter = MOUSE_FILTER_IGNORE
		hbox_inventory.mouse_filter = MOUSE_FILTER_IGNORE
		background_blur.visible = false
		
	elif not expand_state:
		self.anchor_top = 0.099
		self.anchor_bottom = 0.901
		expand_button.set_button_icon(minimize_texture)
		expand_state = true
		bag_button.visible = false
		up_arrow.visible = false
		down_arrow.visible = false
		inventory_open.mouse_filter = MOUSE_FILTER_PASS
		hbox_inventory.mouse_filter = MOUSE_FILTER_PASS
		background_blur.visible = true

var data_bk
func _notification(what: int) -> void:
	
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if data_bk:
				data_bk.icon.show()
				data_bk = null

func _on_h_box_inventory_child_entered_tree(_node: Node) -> void:
	
	await inventory_open.world_drop_finished
	
	pickable_array = get_tree().get_nodes_in_group("pickable")
	question_array = get_tree().get_nodes_in_group("question")
	answer_array = get_tree().get_nodes_in_group("answer")
	
	for pick in pickable_array:
		
		if not pick.pick_clicked.is_connected(Global._on_pickable_click):
		
			pick.pick_clicked.connect(Global._on_pickable_click)
	
	var child_size_total = 0
	
	for child in hbox_inventory.get_children():
		child_size_total += (child.basic_x)
		
		if child.item_data.item_name == "Newspaper" and not Global.look_newspaper_passport:
			
			Global.look_newspaper_passport = true
	
	if child_size_total > hbox_size:
		
		var scale_factor = hbox_size/child_size_total
		
		for child in hbox_inventory.get_children():
			
			var x_minimum = child.basic_x * scale_factor
			var y_minimum = child.basic_y * scale_factor
			
			var x_button_minimum = child.basic_button_x * scale_factor
			var y_button_minimum = child.basic_button_y * scale_factor
			
			var x_arrow_minimum = child.basic_arrow_x * scale_factor
			var y_arrow_minimum = child.basic_arrow_y * scale_factor
			
			for c in child.get_node("OpenItemTexture").get_children():
				
				if c.is_class("VBoxContainer"):
					
					c.scale = Vector2(scale_factor,scale_factor)
					
					#c.position = Vector2(((x_minimum/2)-((c.size.x*scale_factor)/2)),((y_minimum/2 - 15)-((c.size.y*scale_factor)/2)))
			
			child.get_node("OpenItemTexture").set_custom_minimum_size(Vector2(x_minimum,y_minimum))
			child.get_node("OpenItemTexture/OpenItemButton").set_custom_minimum_size(Vector2(x_button_minimum,y_button_minimum))
			child.get_node("OpenItemTexture/R Arrow").set_custom_minimum_size(Vector2(x_arrow_minimum,y_arrow_minimum))
			child.get_node("OpenItemTexture/L Arrow").set_custom_minimum_size(Vector2(x_arrow_minimum,y_arrow_minimum))
		
			child.get_node("OpenItemTexture").size = Vector2(0,0)
			child.get_node("OpenItemTexture/OpenItemButton").size = Vector2(0,0)
			child.get_node("OpenItemTexture/R Arrow").size = Vector2(0,0)
			child.get_node("OpenItemTexture/L Arrow").size = Vector2(0,0)
			
			child.get_node("OpenItemTexture/OpenItemButton").position.x = child.get_node("OpenItemTexture").size.x - child.get_node("OpenItemTexture/OpenItemButton").size.x
			child.get_node("OpenItemTexture/R Arrow").position.x = child.get_node("OpenItemTexture").size.x - child.get_node("OpenItemTexture/R Arrow").size.x - 5
			child.get_node("OpenItemTexture/R Arrow").position.y = child.get_node("OpenItemTexture").size.y / 2
			child.get_node("OpenItemTexture/L Arrow").position.x = 5
			child.get_node("OpenItemTexture/L Arrow").position.y = child.get_node("OpenItemTexture").size.y / 2
	else:
		for child in hbox_inventory.get_children():
			
			var x_minimum = child.basic_x
			var y_minimum = child.basic_y
			
			var x_button_minimum = child.basic_button_x
			var y_button_minimum = child.basic_button_y
			
			var x_arrow_minimum = child.basic_arrow_x
			var y_arrow_minimum = child.basic_arrow_y
			
			for c in child.get_node("OpenItemTexture").get_children():
				
				if c.is_class("VBoxContainer"):
					
					c.scale = Vector2(1,1)
			
			child.get_node("OpenItemTexture").set_custom_minimum_size(Vector2(x_minimum,y_minimum))
			child.get_node("OpenItemTexture/OpenItemButton").set_custom_minimum_size(Vector2(x_button_minimum,y_button_minimum))
			child.get_node("OpenItemTexture/R Arrow").set_custom_minimum_size(Vector2(x_arrow_minimum,y_arrow_minimum))
			child.get_node("OpenItemTexture/L Arrow").set_custom_minimum_size(Vector2(x_arrow_minimum,y_arrow_minimum))
		
			child.get_node("OpenItemTexture").size = Vector2(0,0)
			child.get_node("OpenItemTexture/OpenItemButton").size = Vector2(0,0)
			child.get_node("OpenItemTexture/R Arrow").size = Vector2(0,0)
			child.get_node("OpenItemTexture/L Arrow").size = Vector2(0,0)
			
			child.get_node("OpenItemTexture/OpenItemButton").position.x = child.get_node("OpenItemTexture").size.x - child.get_node("OpenItemTexture/OpenItemButton").size.x
			child.get_node("OpenItemTexture/R Arrow").position.x = child.get_node("OpenItemTexture").size.x - child.get_node("OpenItemTexture/R Arrow").size.x - 5
			child.get_node("OpenItemTexture/R Arrow").position.y = child.get_node("OpenItemTexture").size.y / 2
			child.get_node("OpenItemTexture/L Arrow").position.x = 5
			child.get_node("OpenItemTexture/L Arrow").position.y = child.get_node("OpenItemTexture").size.y / 2

func _on_h_box_inventory_child_exiting_tree(_node: Node) -> void:
	
	await inventory_open._on_button_pressed
	
	var child_size_total = 0
	
	for child in hbox_inventory.get_children():
		
		if not child.exiting:
			child_size_total += (child.basic_x)
		else:
			child.exiting = false
	
	if child_size_total > hbox_size:
		
		var scale_factor = hbox_size/child_size_total
		
		for child in hbox_inventory.get_children():
			
			var x_minimum = child.basic_x * scale_factor
			var y_minimum = child.basic_y * scale_factor
			
			var x_button_minimum = child.basic_button_x * scale_factor
			var y_button_minimum = child.basic_button_y * scale_factor
			
			var x_arrow_minimum = child.basic_arrow_x * scale_factor
			var y_arrow_minimum = child.basic_arrow_y * scale_factor
			
			for c in child.get_node("OpenItemTexture").get_children():
				
				if c.is_class("VBoxContainer"):
					
					c.scale = Vector2(scale_factor,scale_factor)
			
			child.get_node("OpenItemTexture").set_custom_minimum_size(Vector2(x_minimum,y_minimum))
			child.get_node("OpenItemTexture/OpenItemButton").set_custom_minimum_size(Vector2(x_button_minimum,y_button_minimum))
			child.get_node("OpenItemTexture/R Arrow").set_custom_minimum_size(Vector2(x_arrow_minimum,y_arrow_minimum))
			child.get_node("OpenItemTexture/L Arrow").set_custom_minimum_size(Vector2(x_arrow_minimum,y_arrow_minimum))
		
			child.get_node("OpenItemTexture").size = Vector2(0,0)
			child.get_node("OpenItemTexture/OpenItemButton").size = Vector2(0,0)
			child.get_node("OpenItemTexture/R Arrow").size = Vector2(0,0)
			child.get_node("OpenItemTexture/L Arrow").size = Vector2(0,0)
			
			child.get_node("OpenItemTexture/OpenItemButton").position.x = child.get_node("OpenItemTexture").size.x - child.get_node("OpenItemTexture/OpenItemButton").size.x
			child.get_node("OpenItemTexture/R Arrow").position.x = child.get_node("OpenItemTexture").size.x - child.get_node("OpenItemTexture/R Arrow").size.x - 5
			child.get_node("OpenItemTexture/R Arrow").position.y = child.get_node("OpenItemTexture").size.y / 2
			child.get_node("OpenItemTexture/L Arrow").position.x = 5
			child.get_node("OpenItemTexture/L Arrow").position.y = child.get_node("OpenItemTexture").size.y / 2
			
	else:
		for child in hbox_inventory.get_children():
			
			var x_minimum = child.basic_x
			var y_minimum = child.basic_y
			
			var x_button_minimum = child.basic_button_x
			var y_button_minimum = child.basic_button_y
			
			var x_arrow_minimum = child.basic_arrow_x
			var y_arrow_minimum = child.basic_arrow_y
			
			for c in child.get_node("OpenItemTexture").get_children():
				
				if c.is_class("VBoxContainer"):
					
					c.scale = Vector2(1,1)
			
			child.get_node("OpenItemTexture").set_custom_minimum_size(Vector2(x_minimum,y_minimum))
			child.get_node("OpenItemTexture/OpenItemButton").set_custom_minimum_size(Vector2(x_button_minimum,y_button_minimum))
			child.get_node("OpenItemTexture/R Arrow").set_custom_minimum_size(Vector2(x_arrow_minimum,y_arrow_minimum))
			child.get_node("OpenItemTexture/L Arrow").set_custom_minimum_size(Vector2(x_arrow_minimum,y_arrow_minimum))
		
			child.get_node("OpenItemTexture").size = Vector2(0,0)
			child.get_node("OpenItemTexture/OpenItemButton").size = Vector2(0,0)
			child.get_node("OpenItemTexture/R Arrow").size = Vector2(0,0)
			child.get_node("OpenItemTexture/L Arrow").size = Vector2(0,0)
			
			child.get_node("OpenItemTexture/OpenItemButton").position.x = child.get_node("OpenItemTexture").size.x - child.get_node("OpenItemTexture/OpenItemButton").size.x
			child.get_node("OpenItemTexture/R Arrow").position.x = child.get_node("OpenItemTexture").size.x - child.get_node("OpenItemTexture/R Arrow").size.x - 5
			child.get_node("OpenItemTexture/R Arrow").position.y = child.get_node("OpenItemTexture").size.y / 2
			child.get_node("OpenItemTexture/L Arrow").position.x = 5
			child.get_node("OpenItemTexture/L Arrow").position.y = child.get_node("OpenItemTexture").size.y / 2
