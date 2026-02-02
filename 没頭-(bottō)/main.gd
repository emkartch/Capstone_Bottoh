extends Node

@onready var pickable_array = get_tree().get_nodes_in_group("pickable")
@onready var question_array = get_tree().get_nodes_in_group("question")
@onready var answer_array = get_tree().get_nodes_in_group("answer")

@onready var page_1 = get_node("NotesContainer/Notepad/Colors")
@onready var page_2 = get_node("NotesContainer/Notepad/Apperance")
@onready var page_3 = get_node("NotesContainer/Notepad/Clothes")
@onready var page_4 = get_node("NotesContainer/Notepad/Hats")

@onready var r_arrow = get_node("NotesContainer/Notepad/R Notepad Arrow")
@onready var l_arrow = get_node("NotesContainer/Notepad/L Notepad Arrow")

var group_type = null
var select_group_type = null

func _ready():
	for pick in pickable_array:
		pick.clicked.connect(_on_click)
	
	
func _process(_delta):
	pass

func _on_click(clicked_node):
	
	if clicked_node.is_in_group("question"):
		group_type = 'question'
	else:
		group_type = 'answer'
	
	if clicked_node.is_select:
		
		clicked_node.select_line.visible = false
		clicked_node.is_select = false
		clicked_node.remove_from_group("selected")
		
	elif not clicked_node.is_select:

		var selected = get_tree().get_nodes_in_group("selected")
		
		if not selected.is_empty():
			for select in selected:
				if select.is_in_group("question"):
					select_group_type = 'question'
				else:
					select_group_type = 'answer'
				
				if group_type == select_group_type:
					select.select_line.visible = false
					select.is_select = false
					select.remove_from_group("selected")
		
		clicked_node.add_to_group("selected")
		
		clicked_node.select_line.visible = true
		clicked_node.is_select = true
	
	group_type = null
	select_group_type = null



func _on_r_notepad_arrow_pressed() -> void:
	if Global.notepad_page == 1:
		page_1.visible = false
		page_2.visible = true
		l_arrow.visible = true
		Global.notepad_page = 2
	elif Global.notepad_page == 2:
		page_2.visible = false
		page_3.visible = true
		Global.notepad_page = 3
	elif Global.notepad_page == 3:
		page_3.visible = false
		page_4.visible = true
		r_arrow.visible = false
		Global.notepad_page = 4


func _on_l_notepad_arrow_pressed() -> void:
	if Global.notepad_page == 2:
		page_2.visible = false
		page_1.visible = true
		l_arrow.visible = false
		Global.notepad_page = 1
	elif Global.notepad_page == 3:
		page_3.visible = false
		page_2.visible = true
		Global.notepad_page = 2
	elif Global.notepad_page == 4:
		page_4.visible = false
		page_3.visible = true
		r_arrow.visible = true
		Global.notepad_page = 3
