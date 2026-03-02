extends Control

@onready var box = $Box
@onready var notify = $Box/Text
@onready var animation = $AnimationPlayer

func display_notif(notif: String):
	
	notify.text = notif
	
	animation.play("notif_in")
	
	await get_tree().create_timer(2.0).timeout
	
	animation.play("notif_out")
