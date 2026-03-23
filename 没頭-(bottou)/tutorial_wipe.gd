extends CanvasLayer

@onready var circle = $CircleColor
@onready var animation = $CircleColor/AnimationPlayer
@onready var text = $Label

func _process(_delta: float) -> void:
	
	if not self.visible:
		
		circle.material.set_shader_parameter("screen_width",0)
		circle.material.set_shader_parameter("screen_height",0)
