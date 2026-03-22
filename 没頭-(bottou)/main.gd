extends Node

@onready var main_background = $MainBackground
@onready var hud = $HUD
@onready var inventory = $Inventory
@onready var dialog = $HUD/InGame/Dialog
@onready var tutorial_wipe = $TutorialWipe
@onready var transition_animation = get_node("/root/Main/SceneTransitionAnimation/AnimationPlayer")
@onready var tutorial_animation = get_node("/root/Main/TutorialWipe/CircleColor/AnimationPlayer")

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
	
	while GameScript.speech_0[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_0[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	GameScript.scene_line += 1
	
	tutorial_wipe.visible = true
	
	tutorial_animation.play("tutorial_1")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_1:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	while not self.has_node("Train"):
		await get_tree().process_frame
	
	await transition_animation.animation_finished
	
	while GameScript.speech_0[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_0[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	GameScript.scene_line += 1
	
	self.get_node("Train/PromptPerson").visible = true
	
	while GameScript.speech_0[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_0[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	self.get_node("Train/PromptPerson").visible = false
	
	Global.level += 1
	
	level_1()

func level_1():
	
	inventory.visible = true
	hud.get_node("InGame/Goal").visible = true
