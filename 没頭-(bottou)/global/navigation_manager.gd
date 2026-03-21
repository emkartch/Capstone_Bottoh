extends Node

# Created with the help of Soma Animus - https://www.youtube.com/watch?v=3AdAnxrZWGo

@onready var main = get_node("/root/Main")
@onready var inventory = get_node("/root/Main/Inventory")
@onready var transition_animation = get_node("/root/Main/SceneTransitionAnimation/AnimationPlayer")
@onready var transition_animation_LR = get_node("/root/Main/SceneTransitionAnimation/LeftRect")
@onready var transition_animation_RR = get_node("/root/Main/SceneTransitionAnimation/RightRect")

const BSO = preload("res://areas/barber shop (outside)/barber_shop_outside.tscn")
const B = preload("res://areas/bookstore/bookstore.tscn")
const BO = preload("res://areas/bookstore (outside)/bookstore_outside.tscn")
const ClSO = preload("res://areas/clothing store (outside)/clothing_store_outside.tscn")
const CS = preload("res://areas/convenience store/convenience_store.tscn")
const CSO = preload("res://areas/convenience store (outside)/convenience_store_outside.tscn")
const HSO = preload("res://areas/hardware store (outside)/hardware_store_outside.tscn")
const SS = preload("res://areas/stationary store/stationary_store.tscn")
const SSO = preload("res://areas/stationary store (outside)/stationary_store_outside.tscn")
const SV1 = preload("res://areas/street views/street view 1/street_view_1.tscn")
const SV2 = preload("res://areas/street views/street view 2/street_view_2.tscn")
const SV3 = preload("res://areas/street views/street view 3/street_view_3.tscn")
const T = preload("res://areas/train/train.tscn")

const BO_Door_Open = preload("res://areas/bookstore (outside)/BO_Door_Open.png")
const CSO_Door_Open = preload("res://areas/convenience store (outside)/CSO_Door_Open.png")
const SSO_Door_Open = preload("res://areas/stationary store (outside)/SSO_Door_Open.png")

var barber_shop_outside
var bookstore
var bookstore_outside
var clothing_store_outside
var convenience_store
var convenience_store_outside
var hardware_store_outside
var stationary_store
var stationary_store_outside
var street_view_1
var street_view_2
var street_view_3
var train

func _ready():
	barber_shop_outside = BSO.instantiate()
	bookstore = B.instantiate()
	bookstore_outside = BO.instantiate()
	clothing_store_outside = ClSO.instantiate()
	convenience_store = CS.instantiate()
	convenience_store_outside = CSO.instantiate()
	hardware_store_outside = HSO.instantiate()
	stationary_store = SS.instantiate()
	stationary_store_outside = SSO.instantiate()
	street_view_1 = SV1.instantiate()
	street_view_2 = SV2.instantiate()
	street_view_3 = SV3.instantiate()
	train = T.instantiate()
	
	main.add_child(street_view_1)
	main.move_child(street_view_1,0)
	street_view_1.layer = -2

func go_to_level(curr_level_tag,new_level_tag):
	
	var scene_to_remove
	var scene_to_load
	
	match curr_level_tag:
		"barber_shop_outside":
			scene_to_remove = barber_shop_outside
		"bookstore":
			scene_to_remove = bookstore
		"bookstore_outside":
			scene_to_remove = bookstore_outside
		"clothing_store_outside":
			scene_to_remove = clothing_store_outside
		"convenience_store":
			scene_to_remove = convenience_store
		"convenience_store_outside":
			scene_to_remove = convenience_store_outside
		"hardware_store_outside":
			scene_to_remove = hardware_store_outside
		"stationary_store":
			scene_to_remove = stationary_store
		"stationary_store_outside":
			scene_to_remove = stationary_store_outside
		"street_view_1":
			scene_to_remove = street_view_1
		"street_view_2":
			scene_to_remove = street_view_2
		"street_view_3":
			scene_to_remove = street_view_3
		"train":
			scene_to_remove = train
	
	match new_level_tag:
		"barber_shop_outside":
			scene_to_load = barber_shop_outside
		"bookstore":
			scene_to_load = bookstore
		"bookstore_outside":
			scene_to_load = bookstore_outside
		"clothing_store_outside":
			scene_to_load = clothing_store_outside
		"convenience_store":
			scene_to_load = convenience_store
		"convenience_store_outside":
			scene_to_load = convenience_store_outside
		"hardware_store_outside":
			scene_to_load = hardware_store_outside
		"stationary_store":
			scene_to_load = stationary_store
		"stationary_store_outside":
			scene_to_load = stationary_store_outside
		"street_view_1":
			scene_to_load = street_view_1
		"street_view_2":
			scene_to_load = street_view_2
		"street_view_3":
			scene_to_load = street_view_3
		"train":
			scene_to_load = train
		
	if scene_to_remove != null && scene_to_load != null:
		
		# Street View Navigation
		if (scene_to_remove == street_view_1 && scene_to_load == street_view_2) or (scene_to_remove == street_view_2 && scene_to_load == street_view_3):
			
			transition_animation_LR.texture = scene_to_remove.get_node("Background").texture
			transition_animation_RR.texture = scene_to_load.get_node("Background").texture
			
			transition_animation.play("right_to_left")
			
			main.remove_child(scene_to_remove)
			main.add_child(scene_to_load)
			main.move_child(scene_to_load,-1)
			scene_to_load.layer = -2
			
			await transition_animation.animation_finished
			
			transition_animation_LR.texture = null
			transition_animation_RR.texture = null
		
		# Street View Navigation
		elif (scene_to_remove == street_view_3 && scene_to_load == street_view_2) or (scene_to_remove == street_view_2 && scene_to_load == street_view_1):
			
			transition_animation_LR.texture = scene_to_load.get_node("Background").texture
			transition_animation_RR.texture = scene_to_remove.get_node("Background").texture
			
			transition_animation.play("left_to_right")
			
			main.remove_child(scene_to_remove)
			main.add_child(scene_to_load)
			main.move_child(scene_to_load,-1)
			scene_to_load.layer = -2
			
			await transition_animation.animation_finished
			
			transition_animation_LR.texture = null
			transition_animation_RR.texture = null
		
		# Toward outside store (left)
		elif (scene_to_remove == street_view_1 && scene_to_load == bookstore_outside) or (scene_to_remove == street_view_2 && scene_to_load == hardware_store_outside) or (scene_to_remove == street_view_3 && scene_to_load == clothing_store_outside):
			
			transition_animation_LR.texture = scene_to_remove.get_node("Background").texture
			
			transition_animation.play("in_store_left_outside")
			
			main.remove_child(scene_to_remove)
			main.add_child(scene_to_load)
			main.move_child(scene_to_load,-1)
			scene_to_load.layer = -2
			
			await transition_animation.animation_finished
			
			transition_animation_LR.texture = null
		
		# Toward outside store (right)
		elif (scene_to_remove == street_view_1 && scene_to_load == convenience_store_outside) or (scene_to_remove == street_view_2 && scene_to_load == barber_shop_outside) or (scene_to_remove == street_view_3 && scene_to_load == stationary_store_outside):
			
			transition_animation_RR.texture = scene_to_remove.get_node("Background").texture
			
			transition_animation.play("in_store_right_outside")
			
			main.remove_child(scene_to_remove)
			main.add_child(scene_to_load)
			main.move_child(scene_to_load,-1)
			scene_to_load.layer = -2
			
			await transition_animation.animation_finished
			
			transition_animation_RR.texture = null
		
		# Away outside store (left)
		elif (scene_to_remove == bookstore_outside && scene_to_load == street_view_1) or (scene_to_remove == hardware_store_outside && scene_to_load == street_view_2) or (scene_to_remove == clothing_store_outside && scene_to_load == street_view_3):
			
			transition_animation_LR.texture = scene_to_load.get_node("Background").texture
			
			transition_animation.play("out_store_left_outside")
			
			main.remove_child(scene_to_remove)
			main.add_child(scene_to_load)
			main.move_child(scene_to_load,-1)
			scene_to_load.layer = -2
			
			await transition_animation.animation_finished
			
			transition_animation_LR.texture = null
		
		# Away outside store (right)
		elif (scene_to_remove == convenience_store_outside && scene_to_load == street_view_1) or (scene_to_remove == barber_shop_outside && scene_to_load == street_view_2) or (scene_to_remove == stationary_store_outside && scene_to_load == street_view_3):
			
			transition_animation_RR.texture = scene_to_load.get_node("Background").texture
			
			transition_animation.play("out_store_right_outside")
			
			main.remove_child(scene_to_remove)
			main.add_child(scene_to_load)
			main.move_child(scene_to_load,-1)
			scene_to_load.layer = -2
			
			await transition_animation.animation_finished
			
			transition_animation_RR.texture = null
		
		# Into a store
		elif (scene_to_remove == bookstore_outside && scene_to_load == bookstore) or (scene_to_remove == convenience_store_outside && scene_to_load == convenience_store) or (scene_to_remove == stationary_store_outside && scene_to_load == stationary_store):
			
			if scene_to_remove == bookstore_outside:
			
				transition_animation_LR.texture = BO_Door_Open
				
			elif scene_to_remove == convenience_store_outside:
			
				transition_animation_LR.texture = CSO_Door_Open
				
			elif scene_to_remove == stationary_store_outside:
			
				transition_animation_LR.texture = SSO_Door_Open
			
			transition_animation.play("store_in")
			
			await transition_animation.animation_finished
			
			main.remove_child(scene_to_remove)
			main.add_child(scene_to_load)
			main.move_child(scene_to_load,-1)
			scene_to_load.layer = -2
			
			transition_animation_LR.texture = null
			
			transition_animation.play("fade_out")
			
			await transition_animation.animation_finished
		
		# Out of a store
		elif (scene_to_remove == bookstore && scene_to_load == bookstore_outside) or (scene_to_remove == convenience_store && scene_to_load == convenience_store_outside) or (scene_to_remove == stationary_store && scene_to_load == stationary_store_outside):
			
			transition_animation.play("fade_in")
			
			await transition_animation.animation_finished
			
			if scene_to_remove == bookstore:
			
				transition_animation_LR.texture = BO_Door_Open
				
			elif scene_to_remove == convenience_store:
			
				transition_animation_LR.texture = CSO_Door_Open
				
			elif scene_to_remove == stationary_store:
			
				transition_animation_LR.texture = SSO_Door_Open
			
			main.remove_child(scene_to_remove)
			main.add_child(scene_to_load)
			main.move_child(scene_to_load,-1)
			scene_to_load.layer = -2
			
			transition_animation.play("store_out")
			
			await transition_animation.animation_finished
			
			transition_animation_LR.texture = null
		
		else:
			transition_animation.play("fade_in")
			main.remove_child(scene_to_remove)
			main.add_child(scene_to_load)
			main.move_child(scene_to_load,-1)
			scene_to_load.layer = -2
			transition_animation.play("fade_out")
		
		var pickable_array = get_tree().get_nodes_in_group("pickable")
		
		for pick in pickable_array:
			
			if not pick.clicked.is_connected(Global._on_pickable_click):
			
				pick.clicked.connect(Global._on_pickable_click)
		
		var interactable_array = get_tree().get_nodes_in_group("interactable")
		
		for interact in interactable_array:
			
			if not interact.interact_clicked.is_connected(Global._on_interactable_click):
			
				interact.interact_clicked.connect(Global._on_interactable_click)
