extends Panel

# Created with the help of Kilo Galaxia - https://www.youtube.com/watch?v=dHPCizHygWA

@onready var item : TextureRect = $Item

func pick_from_slot():
	item.texture = null

func put_into_slot(new_texture):
	item.texture = new_texture
