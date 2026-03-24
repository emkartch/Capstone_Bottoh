extends Control

@onready var box = $Box
@onready var notify = $Box/Text
@onready var animation = $AnimationPlayer

func display_notif(notif: String,text_size: int):
	
	notify.text = notif
	
	notify.add_theme_font_size_override("font_size",text_size)
	
	animation.play("notif_in")
	
	await get_tree().create_timer(2.0).timeout
	
	animation.play("notif_out")
	
	await animation.animation_finished
