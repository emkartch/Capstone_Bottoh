extends Panel

# Created with the help of Octodemy - https://www.youtube.com/watch?v=JUR1qQ79eJY

@onready var inventory = $"../../../.."
@onready var inventory_container = get_node("/root/Main/Inventory/InventoryContainer")
@onready var icon : TextureRect = $Item
#@onready var item_data = self.set_meta('item_data', item)
@export var item: ItemData :
	set(value):
		item = value
		if is_node_ready() and item:
			update_ui()

var is_hover = false
var is_select = false

var inventory_open = false

signal clicked(emitter_node)

func _ready() -> void:
	update_ui()
	
	self.set_meta('item_data', item)
	
	if item.item_name == "Notebook":
		
		self.add_to_group("notebook")

func _process(_delta):
	
	if is_hover:
		if icon.visible:
			if not inventory_container.expand_state:
				if Input.is_action_just_pressed("click"):
					emit_signal("clicked", self)
	
	if inventory_container.expand_state:
		
		inventory_open = true
		
	else:
		
		inventory_open = false
	
	if icon.texture != null:
		icon.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		icon.mouse_default_cursor_shape = Control.CURSOR_ARROW

func update_ui() -> void:
	if not item:
		icon.texture = null
		return
	
	icon.texture = item.icon
	icon.show()
	tooltip_text = item.item_name

func _get_drag_data(_at_position: Vector2) -> Variant:
	
	if not item:
		return
	
	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	c.z_index = 2
	preview.position -= Vector2(70,70)
	preview.self_modulate = Color.TRANSPARENT
	c.modulate = Color(c.modulate, 0.5)
	
	set_drag_preview(c)
	icon.hide()
	
	return self

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var tmp = item
	item = data.item
	data.item = tmp
	icon.show()
	data.icon.show()
	update_ui()
	data.update_ui()

func _on_mouse_entered() -> void:
	
	is_hover = true
	
	icon.material.set_shader_parameter("color",Color.WHITE)
	
	if not is_select:
		
		icon.material.set_shader_parameter("width",5)

func _on_mouse_exited() -> void:
	is_hover = false
	
	if is_select:
		
		icon.material.set_shader_parameter("color",Color.GOLD)

	if not is_select:
	
		icon.material.set_shader_parameter("width",0)
