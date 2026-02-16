extends Control

const world_item = preload("res://inventory/world_item.tscn")

@onready var inventory_container = $"../InventoryContainer"

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

		node.texture = data.item.item
		
		$HBoxInventory.add_child(node)
		
		node.get_node("OpenItemButton").pressed.connect(_on_button_pressed.bind(node))
		
		data.item = null

func _on_button_pressed(node):
	
	for slot in %VBoxInventory.get_children():
		if slot.item: continue
		
		slot.item = node.get_meta("item_data")	
		slot.update_ui()
		node.queue_free()
		break
