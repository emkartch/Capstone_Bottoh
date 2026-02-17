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

# custom cursor
const hand_point = null #preload()
const hand_closed = null #preload()
# custom cursor

var open_texture = preload("res://inventory/MessangerbagOpen.png")
var closed_texture = preload("res://inventory/MessangerbagClosed.png")
var expand_texture = preload("res://inventory/Expandbutton.png")
var minimize_texture = preload("res://inventory/MinimizeButton.png")

var state = false
var expand_state = false

func _ready():
	
	up_arrow.disabled = true
	
	# CUSTOM CURSOR
	#Input.set_custom_mouse_cursor(hand_point, Input.CURSOR_ARROW)
	#Input.set_custom_mouse_cursor(hand_closed, Input.CURSOR_FORBIDDEN)
	#Input.set_custom_mouse_cursor(hand_closed, Input.CURSOR_CAN_DROP)
	#Input.set_custom_mouse_cursor(hand_closed, Input.CURSOR_DRAG)
	# CUSTOM CURSOR

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
	
	# get rid of cursor change until custom cursor
	
	if Input.get_current_cursor_shape() == CURSOR_FORBIDDEN:
		DisplayServer.cursor_set_shape(DisplayServer.CURSOR_ARROW)
	
	# get rid of cursor change until custom cursor

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
