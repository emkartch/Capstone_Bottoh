extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var left_rect = $LeftRect
@onready var right_rect = $RightRect

func _process(_delta):
	
	if color_rect.color.a > 0:
		color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	if left_rect.texture != null:
		left_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		left_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	if right_rect.texture != null:
		right_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		right_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
