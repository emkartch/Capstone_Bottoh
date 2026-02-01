extends Node

@onready var pickable_array = get_tree().get_nodes_in_group("pickable")
@onready var question_array = get_tree().get_nodes_in_group("question")
@onready var answer_array = get_tree().get_nodes_in_group("answer")

func _ready():
	for pick in pickable_array:
		pick.clicked.connect(_on_click)
	
func _process(_delta):
	pass

func _on_click(clicked_node):
	
	if clicked_node.is_select:
		
		clicked_node.select_line.visible = false
		clicked_node.is_select = false
		clicked_node.remove_from_group("selected")
		
	elif not clicked_node.is_select:

		var selected = get_tree().get_nodes_in_group("selected")

		if not selected.is_empty():
			selected[0].select_line.visible = false
			selected[0].is_select = false
			selected[0].remove_from_group("selected")
		
		clicked_node.add_to_group("selected")
		
		clicked_node.select_line.visible = true
		clicked_node.is_select = true
