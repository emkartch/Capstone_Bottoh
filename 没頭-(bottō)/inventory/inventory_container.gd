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

var state = false
var expand_state = false

var hbox_size = null

func _ready():
	
	up_arrow.disabled = true
	
	hbox_size = 1526 #hbox_inventory.size.x

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
	
	if final_value > 320:
		final_value = 320

	scroll_container.set_v_scroll(final_value)

func _on_messanger_bag_pressed() -> void:
	
	if state:
		bag_button.set_button_icon(closed_texture)
		state = false
		self.visible = false
	elif not state:
		bag_button.set_button_icon(open_texture)
		state = true
		self.visible = true

func _on_expand_button_pressed() -> void:
	
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
	
	var child_size_total = 0
	
	for child in hbox_inventory.get_children():
		child_size_total += (child.basic_x)
	
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
		if not child.is_queued_for_deletion():
			child_size_total += (child.basic_x)
	
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
					
					c.scale = Vector2(1,1)
					
					#c.position = Vector2((x_minimum/2)-(c.size.x/2),((y_minimum/2 - 15)-(c.size.y/2)))
			
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
