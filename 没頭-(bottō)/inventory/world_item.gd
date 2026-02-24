extends CenterContainer

@onready var item_data = self.get_meta('item_data')
@onready var r_arrow = $"OpenItemTexture/R Arrow"
@onready var l_arrow = $"OpenItemTexture/L Arrow"

var margins = 128

var basic_x = null

var basic_y = null

var basic_button_x = null

var basic_button_y = null

var basic_arrow_x = null

var basic_arrow_y = null

func _process(_delta):
	
	if item_data.pages > 1:
		r_arrow.visible = true
		l_arrow.visible = false
	else:
		r_arrow.visible = false
		l_arrow.visible = false
	
