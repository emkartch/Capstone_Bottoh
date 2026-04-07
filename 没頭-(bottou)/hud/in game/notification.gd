extends Control

@onready var box = $Box
@onready var notify = $Box/Text
@onready var animation = $AnimationPlayer
#@onready var blocker = get_node("/root/Main/Blocker")

func display_notif(notif: String,text_size: int):
	
	#blocker.mouse_filter = Control.MOUSE_FILTER_STOP
	
	if notif == "Correct":
		
		Audio.play_audio('sfx',Audio.sfx_correct)
		
	elif notif == "Incorrect":
		
		Audio.play_audio('sfx',Audio.sfx_incorrect)
		
	else:
		
		Audio.play_audio('sfx',Audio.sfx_paper_rustle)
	
	notify.text = notif
	
	notify.add_theme_font_size_override("font_size",text_size)
	
	animation.play("notif_in")
	
	await get_tree().create_timer(2.0).timeout
	
	animation.play("notif_out")
	
	await animation.animation_finished
	
	#blocker.mouse_filter = Control.MOUSE_FILTER_IGNORE
