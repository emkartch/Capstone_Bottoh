extends Node

@onready var main_background = $MainBackground
@onready var hud = $HUD
@onready var inventory = $Inventory

func level_0():
	
	main_background.texture = preload("res://areas/airport/Airport.png")

func level_1():
	
	inventory.visible = true
	hud.get_node("$InGame/Goal").visible = true
