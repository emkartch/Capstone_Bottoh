extends CanvasLayer

@onready var main = get_node("/root/Main")
@onready var blocker = get_node("/root/Main/Blocker")
@onready var dialog = $InGame/Dialog
@onready var notif = $InGame/Notification

@onready var goal_button = $InGame/Goal/GoalButton
@onready var goal_open = $InGame/Goal/GoalOpen
@onready var goal_text = $InGame/Goal/GoalOpen/VBoxContainer/GoalText
@onready var tutorial_button = $InGame/Tutorial

@onready var logo_screen = $LogoScreen
@onready var title_screen = $TitleScreen
@onready var in_game = $InGame
@onready var last_scene = $LastScene
@onready var credits = $Credits

@onready var transition_animation = get_node("/root/Main/SceneTransitionAnimation/AnimationPlayer")
@onready var title_screen_animate = $TitleScreen/AnimationPlayer
@onready var title_screen_background = $TitleScreen/Background
@onready var title_screen_uspassport = $TitleScreen/USPassport
@onready var title_screen_jpnpassport = $TitleScreen/JPNPassport
@onready var title_screen_logo = $TitleScreen/TitleLogo
@onready var title_screen_buttons = $TitleScreen/TSButtons
@onready var title_screen_start = $TitleScreen/TSButtons/MainButtons/StartButton
@onready var title_screen_settings = $TitleScreen/TSButtons/MainButtons/SettingsButton

@onready var last_scene_animation = $LastScene/AnimationPlayer

@onready var credits_animation = $Credits/AnimationPlayer

var goal_texture = preload("res://assets/Notebookpaper.png")
var goal_update_texture = preload("res://assets/PenWNotepad.png")

func _ready():
	
	logo_screen.visible = true
	title_screen.visible = false
	in_game.visible = false
	last_scene.visible = false
	credits.visible = false
	
	title_screen_buttons.modulate.a = 0
	
	title_screen_background.texture = preload("res://hud/title screen/TitleScreen1.png")
	title_screen_uspassport.position.x = 1920
	title_screen_logo.position.x = -720
	title_screen_jpnpassport.position = Vector2(148,-498)
	
	goal_open.get_node("VBoxContainer/GoalText").text = GameScript.goal_0

func _process(_delta):
	
	if title_screen_buttons.modulate.a != 1:
		
		title_screen_start.disabled = true
		title_screen_start.set_default_cursor_shape(Input.CURSOR_ARROW)
		title_screen_settings.disabled = true
		title_screen_settings.set_default_cursor_shape(Input.CURSOR_ARROW)
		
	else:
		
		title_screen_start.disabled = false
		title_screen_start.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		title_screen_settings.disabled = false
		title_screen_settings.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func show_start():
	
	transition_animation.play("fade_out")
	
	await get_tree().create_timer(3.0).timeout 
	
	transition_animation.play("fade_in")
	
	await transition_animation.animation_finished
	
	logo_screen.visible = false
	title_screen.visible = true
	await get_tree().create_timer(1.0).timeout 
	
	transition_animation.play("fade_out")
	
	await transition_animation.animation_finished
	
	title_screen_animate.play("title_screen")
	
	await title_screen_animate.animation_finished

func show_end():
	
	last_scene_animation.play("last_scene")
	
	await last_scene_animation.animation_finished
	
	credits.visible = true
	
	await show_credits()
	
	Global.game_end = true

func show_credits():
	
	credits_animation.play("credits")
	
	await credits_animation.animation_finished

func next_level_tutorial():
	
	tutorial_button.visible = false
	
	dialog.display_line(true,false,"Now we have to figure out the English meanings of the information found on the note in your inventory.","Tutorial")
	
	await dialog.continue_true
	
	dialog.display_line(true,false,"To do this, open your notebook and note in your expanded inventory by selecting the expand button at the top right of your inventory, then dragging your notebook and your note to the center of the screen.","Tutorial")
	
	await dialog.continue_true
	
	dialog.display_line(true,false,"Use your notebook and flip through the pages using the arrows on screen to match the English defintions to the Japanese characters.","Tutorial")
	
	await dialog.continue_true
	
	tutorial_button.visible = true

func _on_goal_button_pressed() -> void:
	
	#if Global.level == 1 and Global.tutorial_2 == false:
		#
		#Global.tutorial_2 = true
	
	goal_button.visible = false
	goal_open.visible = true

func _on_exit_goal_button_pressed() -> void:
	
	goal_open.visible = false
	goal_button.visible = true

func _on_tutorial_pressed() -> void:
	
	pass
	
	#if Global.level == 1:
		#show_start()
	#elif Global.level ==2:
		#next_level_tutorial()

func _on_start_button_pressed() -> void:
	
	transition_animation.play("fade_in")
	
	await transition_animation.animation_finished
	
	title_screen.visible = false
	in_game.visible = true
	
	main.level_0()

func update_goal_text(goal):
	
	blocker.mouse_filter = Control.MOUSE_FILTER_STOP
	
	goal_text.text = goal
	
	goal_button.texture_normal = goal_update_texture
	
	await notif.display_notif("Goal Updated",60)
	
	goal_button.texture_normal = goal_texture
	
	blocker.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_credits_button_pressed() -> void:
	
	transition_animation.play("fade_in")
	
	await transition_animation.animation_finished
	
	credits.visible = true
	
	transition_animation.play("fade_out")
	
	await transition_animation.animation_finished
	
	await show_credits()
	
	transition_animation.play("fade_in")
	
	await transition_animation.animation_finished
	
	credits.visible = false
	
	transition_animation.play("fade_out")
