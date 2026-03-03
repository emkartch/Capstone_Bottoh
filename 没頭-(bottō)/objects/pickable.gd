extends Control

@onready var label = $Label
@onready var object = $Object
@onready var collision_shape = $Area2D/CollisionShape2D
@onready var area_2d = $Area2D
@onready var select_line = $SelectLine

@export var item: Texture2D
@export var description: String

const cursor_normal = preload("res://assets/CursorArrow.png")
const cursor_point = preload("res://assets/CursorHand.png")

var is_hover = false
var is_select = false
var pick_size: Vector2

signal clicked(emitter_node)

func _ready():
	update_collision_shape()
	
func _process(_delta):
	if is_hover:
		if Input.is_action_just_pressed("click"):
			emit_signal("clicked", self)

func update_collision_shape():
	
	if item != null:
		object.texture = item
		object.visible = true
		# Ensure the texture size is updated before getting the size
		object.size = object.texture.get_size()
		# Get the size of the texture's bounding box
		pick_size = object.size
	else:
		label.visible = true
		# Ensure the label's text is updated before getting the size
		label.size = Vector2(0,0)
		# Get the size of the text's bounding box
		pick_size = label.size
	
	# Create a new RectangleShape2D and set its size
	var shape := RectangleShape2D.new()
	# The extents property is half of the total size, so divide by 2
	shape.size = pick_size

	# Assign the new shape to the CollisionShape2D node
	collision_shape.shape = shape
	
	area_2d.position.x = pick_size[0] / 2
	area_2d.position.y = pick_size[1] / 2
	#
	#print(self.size.y)
	
	select_line.position.y = pick_size[1]
	select_line.points[1][0] = pick_size[0]
	
	# Optional: adjust label position if needed (e.g., center it relative to the collision shape's origin)
	# label.position = -text_size / 2.0 # if the parent's origin is the center

func _on_area_2d_mouse_entered() -> void:
	is_hover = true
	
	if self.modulate.a != 0:
	
		Input.set_custom_mouse_cursor(cursor_point)
	
	if item == null:
	
		label.add_theme_color_override("font_color", Color.BLACK)
		label.add_theme_color_override("font_shadow_color", Color.DIM_GRAY)
	
	else:
	
		object.material.set_shader_parameter("color",Color.DIM_GRAY)
	
		if not is_select:
		
			object.material.set_shader_parameter("width",10)

func _on_area_2d_mouse_exited() -> void:
	is_hover = false
	Input.set_custom_mouse_cursor(cursor_normal)
	
	if item == null:
		
		label.remove_theme_color_override("font_color")
		label.remove_theme_color_override("font_shadow_color")
		
	else:
		
		if is_select:
			
			object.material.set_shader_parameter("color",Color.GOLD)
	
		if not is_select:
		
			object.material.set_shader_parameter("width",0)
