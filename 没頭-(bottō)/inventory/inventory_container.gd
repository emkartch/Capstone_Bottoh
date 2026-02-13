extends TextureRect

# Created with the help of Kilo Galaxia - https://www.youtube.com/watch?v=dHPCizHygWA

@onready var scroll_container = $ScrollContainer
@onready var up_arrow = $UpArrow
@onready var down_arrow = $DownArrow
@onready var bag_button = $"../MessangerBag"
@onready var expand_button = $ExpandButton
@onready var moveable_item = $MoveableItem

#const SlotClass = preload("res://inventory/slot.gd")
#var temp_item_texture = null
#var current_slot = null
#var next_slot = null
#var place_item = false
#var timer = 0.1

var open_texture = preload("res://inventory/MessangerbagOpen.png")
var closed_texture = preload("res://inventory/MessangerbagClosed.png")
var expand_texture = preload("res://inventory/Expandbutton.png")
var minimize_texture = preload("res://inventory/MinimizeButton.png")

var state = false
var expand_state = false

func _ready():
	
	up_arrow.disabled = true
	
	#for v_slot in scroll_container.get_node("VBoxContainer").get_children():
		#v_slot.connect("gui_input",slot_gui_input)
		## v_slot.connect("gui_input", self, "slot_gui_input", [v_slot])

func _process(_delta):
	
	var value = scroll_container.get_v_scroll()
	
	if value == 0:
		up_arrow.disabled = true
	else:
		up_arrow.disabled = false
	
	if value == 320:
		down_arrow.disabled = true
	else:
		down_arrow.disabled = false
		
	#if(place_item):
		#timer -= delta
		#
		#if(timer <= 0):
			#place_item = false
			#timer = 0.1

#func slot_gui_input(event: InputEvent): #event: InputEvent, slot: SlotClass):
	#
	#var slot = SlotClass
	#
	#if(place_item):
		#next_slot = slot
		#
		## don't overwrite item
		#if(next_slot.item.texture == null):
			#current_slot.pick_from_slot()
			#next_slot.put_into_slot(temp_item_texture)
			#temp_item_texture = null
			#place_item = false
	#
	#if(event is InputEventMouseButton):
		## left mouse click pressed
		#if(event.button_index) == MOUSE_BUTTON_LEFT && event.pressed:
			#temp_item_texture = slot.item.get_texture()
			#current_slot = slot
			#moveable_item.visible = true
			#moveable_item.get_node("Item").texture = temp_item_texture
			#moveable_item.global_position = current_slot.item.get_global_transform().origin
			#current_slot.pick_from_slot()
			#
		## left mouse click released
		#if(event.button_index) == MOUSE_BUTTON_LEFT && !event.pressed:
			#moveable_item.visible = false
			#
			#if(temp_item_texture != null):
				#current_slot.put_into_slot(temp_item_texture)
				#place_item = true
#
#func _input(_event):
	#
	#if(moveable_item.visible):
		#
		#moveable_item.global_position = get_global_mouse_position() + Vector2(-60,-60)

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
	
	print(state)
	
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
		#self.visible = false
	elif not expand_state:
		self.anchor_top = 0.099
		self.anchor_bottom = 0.901
		expand_button.set_button_icon(minimize_texture)
		expand_state = true
		bag_button.visible = false
		up_arrow.visible = false
		down_arrow.visible = false
		#self.visible = true
