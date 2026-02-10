extends ColorRect

@onready var scroll_container = $ScrollContainer
@onready var up_arrow = $UpArrow
@onready var down_arrow = $DownArrow
@onready var bag_button = $"../MessangerBag"
@onready var expand_button = $ExpandButton

var open_texture = preload("res://inventory/MessangerbagOpen.png")
var closed_texture = preload("res://inventory/MessangerbagClosed.png")
var expand_texture
var minimize_texture

var state = false
var expand_state = false

func _ready():
	
	up_arrow.disabled = true
	
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
		expand_button.set_button_icon(minimize_texture)
		expand_state = false
		#self.visible = false
	elif not expand_state:
		expand_button.set_button_icon(expand_texture)
		expand_state = true
		#self.visible = true
