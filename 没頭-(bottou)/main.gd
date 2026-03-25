extends Node

@onready var main_background = $MainBackground
@onready var hud = $HUD
@onready var inventory = $Inventory
@onready var inventory_container = $Inventory/InventoryContainer
@onready var dialog = $HUD/InGame/Dialog
@onready var goal = get_node("/root/Main/HUD/InGame/Goal")
@onready var goal_text = get_node("/root/Main/HUD/InGame/Goal/GoalOpen/VBoxContainer/GoalText")
@onready var notif = get_node("/root/Main/HUD/InGame/Notification")
@onready var tutorial_wipe = $TutorialWipe
@onready var transition = $SceneTransitionAnimation
@onready var transition_animation = get_node("/root/Main/SceneTransitionAnimation/AnimationPlayer")
@onready var tutorial_animation = get_node("/root/Main/TutorialWipe/CircleColor/AnimationPlayer")

const newspaper_ID = preload("res://inventory/item data/newspaper.tres")
const new_map_ID = preload("res://inventory/item data/new_map.tres")
const note_ID = preload("res://inventory/item data/note.tres")
const old_map_ID = preload("res://inventory/item data/old_map.tres")
const passport_ID = preload("res://inventory/item data/passport.tres")

var view_SV1 = false
var view_SV2 = false
var view_SV3 = false

var SV3_BLUE = preload("res://areas/street views/street view 3/street view 3 (BLUE)/StreetView3BLUE.png")
var SSO_BLUE = preload("res://areas/stationary store (outside)/stationary store (outside zoom)/SSO_Back_Layer(BLUE).png")

var train_no_police = preload("res://areas/train/TrainNoPolice.png")

func _process(_delta):
	
	if main_background.texture == null:
		main_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		main_background.mouse_filter = Control.MOUSE_FILTER_STOP

func level_0():
	
	main_background.texture = preload("res://areas/airport/Airport.png")
	
	transition_animation.play("fade_out")
	
	await transition_animation.animation_finished
	
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
	
	await transition_animation.animation_finished
	
	# AFTER AIRPORT
	while GameScript.speech_0[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_0[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	GameScript.scene_line += 1
	
	tutorial_wipe.visible = true
	
	Global.tut_1_playing = true
	
	tutorial_animation.play("tutorial_1")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_1:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	while not self.has_node("Train"):
		await get_tree().process_frame

	await transition.anim_finished
	
	while GameScript.speech_0[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_0[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	GameScript.scene_line += 1
	
	self.get_node("Train/PromptPersonBack").visible = false
	
	self.get_node("Train/PromptPersonFront").visible = true
	
	while GameScript.speech_0[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_0[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	self.get_node("Train/PromptPersonFront").visible = false
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_1()

func level_1():
	
	goal.visible = true
	
	await hud.update_goal_text(GameScript.goal_1)
	
	tutorial_wipe.visible = true
	
	Global.tut_2_playing = true
	
	tutorial_animation.play("tutorial_2")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_2:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	while self.has_node("Train"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	NavigationManager.train.get_node("PolicePerson").visible = false
	
	while not self.has_node("StreetView1"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	tutorial_wipe.visible = true
	
	Global.tut_3_playing = true
	
	tutorial_animation.play("tutorial_3")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_3:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	while not self.has_node("ConvenienceStoreOutside"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	tutorial_wipe.visible = true
	
	Global.tut_4_playing = true
	
	tutorial_animation.play("tutorial_4")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_4:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	while not self.has_node("ConvenienceStore"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	while GameScript.speech_1[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_1[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_2()

func level_2():
	
	await hud.update_goal_text(GameScript.goal_2)
	
	tutorial_wipe.visible = true
	
	Global.tut_5_playing = true
	
	tutorial_animation.play("tutorial_5")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_5:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	while not self.has_node("ConvenienceStoreZoom"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	while GameScript.speech_2[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_2[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_3()

func level_3():
	
	await hud.update_goal_text(GameScript.goal_3)
	
	while not self.has_node("ConvenienceStore"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	tutorial_wipe.visible = true
	
	Global.tut_6_playing = true
	
	tutorial_animation.play("tutorial_6")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_6:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	while not Global.have_newspaper:
		await get_tree().process_frame
	
	await notif.display_notif("Newspaper added to Inventory",38)
	
	inventory.visible = true
	
	tutorial_wipe.visible = true
	
	Global.tut_7_playing = true
	
	tutorial_animation.play("tutorial_7")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_7:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	tutorial_wipe.visible = true
	
	Global.tut_8_playing = true
	
	tutorial_animation.play("tutorial_8")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_8:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	tutorial_wipe.visible = true
	
	Global.tut_9_playing = true
	
	tutorial_animation.play("tutorial_9")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_9:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	while not Global.look_newspaper_passport:
		await get_tree().process_frame
	
	while GameScript.speech_3[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_3[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_4()

func level_4():
	
	await hud.update_goal_text(GameScript.goal_4)
	
	while not self.has_node("ConvenienceStoreZoom"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	while GameScript.speech_4[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_4[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	for slot in inventory_container.get_node("ScrollContainer/VBoxInventory").get_children():
		
		if slot.item == null:
			
			slot.item = new_map_ID
			
			break
	
	await notif.display_notif("New Map added to Inventory",38)
	
	while GameScript.speech_4[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_4[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_5()

func level_5():
	
	await hud.update_goal_text(GameScript.goal_5)
	
	while not self.has_node("Bookstore"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	while GameScript.speech_5[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_5[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_6()

func level_6():
	
	await hud.update_goal_text(GameScript.goal_6)
	
	while not self.has_node("BookstoreZoom"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	while GameScript.speech_6[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_6[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	for slot in inventory_container.get_node("ScrollContainer/VBoxInventory").get_children():
		
		if slot.item == null:
			
			slot.item = old_map_ID
			
			break
	
	await notif.display_notif("Old Map added to Inventory",38)
	
	while GameScript.speech_6[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_6[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_7()

func level_7():
	
	await hud.update_goal_text(GameScript.goal_7)
	
	await NavigationManager.look_for_vintage
	
	while GameScript.speech_7[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_7[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_8()

func level_8():
	
	await hud.update_goal_text(GameScript.goal_8)
	
	await inventory_container.level_8_newspaper
	
	tutorial_wipe.visible = true
	
	Global.tut_10_playing = true
	
	tutorial_animation.play("tutorial_10")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_10:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	await inventory_container.second_page_newspaper
	
	while GameScript.speech_8[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_8[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_9()

func level_9():
	
	await hud.update_goal_text(GameScript.goal_9)
	
	tutorial_wipe.visible = true
	
	Global.tut_11_playing = true
	
	tutorial_animation.play("tutorial_11")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_11:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	await inventory_container.map_look
	
	while GameScript.speech_9[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_9[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_10()

func level_10():
	
	await hud.update_goal_text(GameScript.goal_10)
	
	while not self.has_node("StationaryStore"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	while GameScript.speech_10[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_10[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_11()

func level_11():
	
	await hud.update_goal_text(GameScript.goal_11)
	
	while not self.has_node("StationaryStoreZoom"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	while GameScript.speech_11[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_11[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	for slot in inventory_container.get_node("ScrollContainer/VBoxInventory").get_children():
		
		if slot.item == null:
			
			slot.item = note_ID
			
			break
	
	await notif.display_notif("Note added to Inventory",38)
	
	while GameScript.speech_11[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_11[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	NavigationManager.street_view_3.get_node("Background").texture = SV3_BLUE
	NavigationManager.stationary_store_outside.get_node("Background").texture = SSO_BLUE
	NavigationManager.stationary_store_outside.get_node("Selectables/BlueHatGuy").visible = true
	
	GameScript.scene_line = 0
	
	if Global.notebook_filled:
		
		Global.level += 2
		
		level_13()
		
	else:
		
		Global.level += 1
		
		level_12()

func level_12():
	
	await hud.update_goal_text(GameScript.goal_12)
	
	await Global.full_notebook
	
	Global.level += 1
	
	level_13()

func level_13():
	
	await hud.update_goal_text(GameScript.goal_13)
	
	await inventory_container.notes_look
	
	tutorial_wipe.visible = true
	
	Global.tut_12_playing = true
	
	tutorial_animation.play("tutorial_12")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_12:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	await Global.connect_show
	
	tutorial_wipe.visible = true
	
	Global.tut_13_playing = true
	
	tutorial_animation.play("tutorial_13")
	
	await tutorial_animation.animation_finished
	
	while not Global.tutorial_13:
		await get_tree().process_frame
	
	tutorial_wipe.visible = false
	
	await Global.translated_note
	
	Global.level += 1
	
	level_14()

func level_14():
	
	await hud.update_goal_text(GameScript.goal_14)
	
	NavigationManager.stationary_store_outside.get_node("Selectables/BlueHatGuy").visible = false
	NavigationManager.stationary_store_outside.get_node("Doors/Door_SSOZ").visible = true
	
	while not self.has_node("StationaryStoreOutsideZoom"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	while GameScript.speech_14[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_14[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	for slot in inventory_container.get_node("ScrollContainer/VBoxInventory").get_children():
		
		if slot.item == null:
			
			slot.item = passport_ID
			
			break
	
	await notif.display_notif("Passport added to Inventory",38)
	
	NavigationManager.train.get_node("Selectables/PoliceOfficer").visible = false
	NavigationManager.train.get_node("Doors/Door_TZ_In").visible = true
	
	while GameScript.speech_14[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_14[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	Global.level += 1
	GameScript.scene_line = 0
	
	level_15()

func level_15():
	
	await hud.update_goal_text(GameScript.goal_15)
	
	while not self.has_node("TrainZoom"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	while GameScript.speech_15[GameScript.scene_line] != null:
		
		var line_info = GameScript.speech_15[GameScript.scene_line]
		
		dialog.display_line(true,false,line_info[0],line_info[1],line_info[2])
		
		GameScript.scene_line += 1
		
		await dialog.continue_true
	
	#Global.level += 1
	#GameScript.scene_line = 0
	
	NavigationManager.train.get_node("Background").texture = train_no_police
	
	while not self.has_node("Train"):
		await get_tree().process_frame
	
	await transition.anim_finished
	
	hud.show_end()
