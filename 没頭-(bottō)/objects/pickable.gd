extends Control

@onready var label = $Label #get_node("/root/Pickable/Label")
@onready var collision_shape = $Area2D/CollisionShape2D #get_node("/root/Pickable/Area2D/CollisionShape2D")
@onready var area_2d = $Area2D

func _ready():
	update_collision_shape()

func update_collision_shape():
	# Ensure the label's text is updated before getting the size
	label.size = Vector2(0,0)
	# Get the size of the text's bounding box
	var text_size: Vector2 = label.size
	# Create a new RectangleShape2D and set its size
	var shape := RectangleShape2D.new()
	# The extents property is half of the total size, so divide by 2
	shape.size = text_size

	# Assign the new shape to the CollisionShape2D node
	collision_shape.shape = shape
	
	
	area_2d.position.x = text_size[0] / 2
	area_2d.position.y = text_size[1] / 2
	
	
	# Optional: adjust label position if needed (e.g., center it relative to the collision shape's origin)
	# label.position = -text_size / 2.0 # if the parent's origin is the center
