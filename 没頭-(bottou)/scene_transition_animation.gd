extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var left_rect = $LeftRect
@onready var right_rect = $RightRect
@onready var animation = $AnimationPlayer

signal anim_finished

func _process(_delta):
	
	if color_rect.color.a == 0:
		color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	if left_rect.texture != null:
		left_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		left_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	if right_rect.texture != null:
		right_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		right_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	
	#left_rect.texture = null
	left_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#right_rect.texture = null
	right_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	emit_signal("anim_finished")
