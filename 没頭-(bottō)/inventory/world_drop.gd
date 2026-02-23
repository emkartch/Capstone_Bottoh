extends Control

var world_item = preload("res://inventory/world_item.tscn")

@onready var inventory_container = $"../InventoryContainer"

signal world_drop_finished()

var button_location: Vector2 = Vector2(0,0)

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	if inventory_container.expand_state:
		return true
	else:
		return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	
	if inventory_container.expand_state:
	
		var node = world_item.instantiate()
		
		node.set_meta("item_data", data.item)
		
		node.get_node("OpenItemTexture").texture = data.item.item
		
		var texture_size = node.get_node("OpenItemTexture").texture.get_size()
		
		var texture_position = node.get_node("OpenItemTexture").position
		
		var size_x = texture_size[0] + 128
		
		node.basic_x = size_x
		
		node.basic_y = texture_size[1]
		
		node.basic_button_x = node.get_node("OpenItemTexture/OpenItemButton").texture_normal.get_size()[0]
		
		node.basic_button_y = node.get_node("OpenItemTexture/OpenItemButton").texture_normal.get_size()[1]
		
		node.basic_arrow_x = node.get_node("OpenItemTexture/R Arrow").texture_normal.get_size()[0]
		
		node.basic_arrow_y = node.get_node("OpenItemTexture/R Arrow").texture_normal.get_size()[1]
		
		$HBoxInventory.add_child(node)
		
		var position_x = texture_position[0] - (128.0/2.0)
		
		node.get_node("OpenItemTexture").position.x = position_x
		
		node.get_node("OpenItemTexture").set_custom_minimum_size(Vector2(size_x,texture_size[1]))
		
		node.get_node("OpenItemTexture/OpenItemButton").pressed.connect(_on_button_pressed.bind(node))
		
		data.item = null
	
	world_drop_finished.emit()

func _on_button_pressed(node):
	
	for slot in %VBoxInventory.get_children():
		if slot.item: continue
		
		slot.item = node.get_meta("item_data")	
		slot.update_ui()
		node.queue_free()
		break
