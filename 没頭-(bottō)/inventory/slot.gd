extends Panel

# Created with the help of Octodemy - https://www.youtube.com/watch?v=JUR1qQ79eJY

@onready var item : TextureRect = $Item

func _get_drag_data(_at_position: Vector2) -> Variant:
	
	if item.texture == null:
		return
	
	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	preview.position -= Vector2(70,70)
	preview.self_modulate = Color.TRANSPARENT
	c.modulate = Color(c.modulate, 0.5)
	
	set_drag_preview(c)
	item.hide()
	
	return item

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var tmp = item.texture
	item.texture = data.texture
	data.texture = tmp
	item.show()
	data.show()
