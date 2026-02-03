extends Control

@onready var label = $Label
@onready var collision_shape = $Area2D/CollisionShape2D
@onready var area_2d = $Area2D
@onready var select_line = $SelectLine

var is_hover = false
var is_select = false

signal clicked(emitter_node)

func _ready():
	update_collision_shape()
	
func _process(_delta):
	if is_hover:
		if Input.is_action_just_pressed("click"):
			emit_signal("clicked", self)

func update_collision_shape():
	# Ensure the label's text is updated before getting the size
	label.size = Vector2(0,0)
	# Get the size of the text's bounding box
	var text_size = label.size
	# Create a new RectangleShape2D and set its size
	var shape := RectangleShape2D.new()
	# The extents property is half of the total size, so divide by 2
	shape.size = text_size

	# Assign the new shape to the CollisionShape2D node
	collision_shape.shape = shape
	
	area_2d.position.x = text_size[0] / 2
	area_2d.position.y = text_size[1] / 2
	#
	#print(self.size.y)
	
	select_line.position.y = text_size[1]
	select_line.points[1][0] = text_size[0]
	
	# Optional: adjust label position if needed (e.g., center it relative to the collision shape's origin)
	# label.position = -text_size / 2.0 # if the parent's origin is the center


func _on_area_2d_mouse_entered() -> void:
	is_hover = true
	#if not is_select:
	label.add_theme_color_override("font_color", Color.BLACK)
	label.add_theme_color_override("font_shadow_color", Color.DIM_GRAY)

func _on_area_2d_mouse_exited() -> void:
	is_hover = false
	#if not is_select:
	label.remove_theme_color_override("font_color")
	label.remove_theme_color_override("font_shadow_color")
