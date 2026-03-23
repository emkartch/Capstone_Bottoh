extends Control

@onready var object = $Object
@onready var collision_shape = $Area2D/CollisionShape2D
@onready var area_2d = $Area2D

@export var item_name: String
@export var item: Texture2D
@export_multiline var description: String

const cursor_normal = preload("res://assets/CursorArrow.png")
const cursor_point = preload("res://assets/CursorHand.png")

var is_hover = false
var is_select = false
var pick_size: Vector2

signal interact_clicked(emitter_node)

func _ready():
	update_collision_shape()
	
func _process(_delta):
	if is_hover:
		if Input.is_action_just_pressed("click"):
			emit_signal("interact_clicked", self)

func update_collision_shape():
	
	object.texture = item
	#object.visible = true
	# Ensure the texture size is updated before getting the size
	object.size = object.texture.get_size()
	# Get the size of the texture's bounding box
	pick_size = object.size
	
	# Create a new RectangleShape2D and set its size
	var shape := RectangleShape2D.new()
	# The extents property is half of the total size, so divide by 2
	shape.size = pick_size

	# Assign the new shape to the CollisionShape2D node
	collision_shape.shape = shape
	
	area_2d.position.x = pick_size[0] / 2
	area_2d.position.y = pick_size[1] / 2
	
	#select_line.position.y = pick_size[1]
	#select_line.points[1][0] = pick_size[0]

func _on_area_2d_mouse_entered() -> void:
	is_hover = true
		
	object.material.set_shader_parameter("width",5)

func _on_area_2d_mouse_exited() -> void:
	is_hover = false
	Input.set_custom_mouse_cursor(cursor_normal)
	
	object.material.set_shader_parameter("width",0)


#func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if event is InputEventMouseButton and event.pressed:
		## This prevents the click from reaching nodes behind this Area2D
		#get_viewport().set_input_as_handled()
