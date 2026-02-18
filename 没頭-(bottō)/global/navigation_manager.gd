extends Node

# Created with the help of Soma Animus - https://www.youtube.com/watch?v=3AdAnxrZWGo

@onready var main = get_node("/root/Main")
@onready var inventory = get_node("/root/Main/Inventory")
@onready var transition_animation = get_node("/root/Main/SceneTransitionAnimation/AnimationPlayer")

const BSO = preload("res://areas/barber shop (outside)/barber_shop_outside.tscn")
const B = preload("res://areas/bookstore/bookstore.tscn")
const BO = preload("res://areas/bookstore (outside)/bookstore_outside.tscn")
const ClSO = preload("res://areas/clothing store (outside)/clothing_store_outside.tscn")
const CS = preload("res://areas/convenience store/convenience_store.tscn")
const CSO = preload("res://areas/convenience store (outside)/convenience_store_outside.tscn")
const HSO = preload("res://areas/hardware store (outside)/hardware_store_outside.tscn")
const SS = preload("res://areas/stationary store/stationary_store.tscn")
const SSO = preload("res://areas/stationary store (outside)/stationary_store_outside.tscn")
const SV = preload("res://areas/street view/street_view.tscn")

var barber_shop_outside
var bookstore
var bookstore_outside
var clothing_store_outside
var convenience_store
var convenience_store_outside
var hardware_store_outside
var stationary_store
var stationary_store_outside
var street_view

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
	street_view = SV.instantiate()
	
	main.add_child(street_view)
	main.move_child(street_view,0)
	street_view.layer = -2

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
		"street_view":
			scene_to_remove = street_view
	
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
		"street_view":
			scene_to_load = street_view
		
	if scene_to_remove != null && scene_to_load != null:

		transition_animation.play("fade_in")
		main.remove_child(scene_to_remove)
		main.add_child(scene_to_load)
		main.move_child(scene_to_load,-1)
		scene_to_load.layer = -2
		transition_animation.play("fade_out")
