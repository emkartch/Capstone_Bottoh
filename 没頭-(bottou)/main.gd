extends Node

@onready var main_background = $MainBackground
@onready var hud = $HUD
@onready var inventory = $Inventory
@onready var dialog = $HUD/InGame/Dialog
@onready var transition_animation = get_node("/root/Main/SceneTransitionAnimation/AnimationPlayer")

func _process(_delta):
	
	if main_background.texture == null:
		main_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		main_background.mouse_filter = Control.MOUSE_FILTER_STOP

func level_0():
	
	main_background.texture = preload("res://areas/airport/Airport.png")
	
	transition_animation.play("fade_out")
	
	await transition_animation.animation_finished
	
	await get_tree().create_timer(1.0).timeout
	
	while GameScript.speech_0[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_0[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
		
	GameScript.scene_line += 1
	
	transition_animation.play("fade_in")
	
	await transition_animation.animation_finished
	
	main_background.texture = null
	
	transition_animation.play("fade_out")
	
	await get_tree().create_timer(1.0).timeout

func level_1():
	
	inventory.visible = true
	hud.get_node("$InGame/Goal").visible = true
