extends Node

@onready var hud = get_parent().get_node("HUD")

@onready var pickable_array = get_tree().get_nodes_in_group("pickable")
@onready var question_array = get_tree().get_nodes_in_group("question")
@onready var answer_array = get_tree().get_nodes_in_group("answer")

@onready var page_number = get_node("NotesContainer/Notepad/PageNumber")

@onready var page_1 = get_node("NotesContainer/Notepad/Colors")
@onready var page_2 = get_node("NotesContainer/Notepad/Apperance")
@onready var page_3 = get_node("NotesContainer/Notepad/Clothes")
@onready var page_4 = get_node("NotesContainer/Notepad/Hats")

@onready var r_arrow = get_node("NotesContainer/Notepad/R Notepad Arrow")
@onready var l_arrow = get_node("NotesContainer/Notepad/L Notepad Arrow")
@onready var submit_button = get_node("NotesContainer/Notepad/Submit")

@onready var looks_ans = get_node("NotesContainer/Notepage/Qcontainer/Looks ENG")
@onready var hair_ans = get_node("NotesContainer/Notepage/Qcontainer/Hair ENG")
@onready var clothes_color_ans = get_node("NotesContainer/Notepage/Qcontainer/Clothes ENG/Clothes Color ENG")
@onready var clothes_type_ans = get_node("NotesContainer/Notepage/Qcontainer/Clothes ENG/Clothes Type ENG")
@onready var hat_ans = get_node("NotesContainer/Notepage/Qcontainer/Hat ENG")

var group_type = null
var select_group_type = null

var looks_correct = false
var hair_correct = false
var clothes_color_correct = false
var clothes_type_correct = false
var hat_correct = false

func _ready():
	for pick in pickable_array:
		pick.clicked.connect(_on_click)
	
	looks_ans.modulate.a = 0
	hair_ans.modulate.a = 0
	clothes_color_ans.modulate.a = 0
	clothes_type_ans.modulate.a = 0
	hat_ans.modulate.a = 0
	
	hud.show_start()
	
func _process(_delta):
	
	if looks_correct and hair_correct and clothes_color_correct and clothes_type_correct and hat_correct:
		hud.show_end()
	
	var selected = get_tree().get_nodes_in_group("selected")
	
	if selected.size() == 2:
		submit_button.visible = true
	else:
		submit_button.visible = false

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
		page_number.text = "2/4"
	elif Global.notepad_page == 2:
		page_2.visible = false
		page_3.visible = true
		Global.notepad_page = 3
		page_number.text = "3/4"
	elif Global.notepad_page == 3:
		page_3.visible = false
		page_4.visible = true
		r_arrow.visible = false
		Global.notepad_page = 4
		page_number.text = "4/4"

func _on_l_notepad_arrow_pressed() -> void:
	if Global.notepad_page == 2:
		page_2.visible = false
		page_1.visible = true
		l_arrow.visible = false
		Global.notepad_page = 1
		page_number.text = "1/4"
	elif Global.notepad_page == 3:
		page_3.visible = false
		page_2.visible = true
		Global.notepad_page = 2
		page_number.text = "2/4"
	elif Global.notepad_page == 4:
		page_4.visible = false
		page_3.visible = true
		r_arrow.visible = true
		Global.notepad_page = 3
		page_number.text = "3/4"

func _on_submit_pressed() -> void:
	
	var selected = get_tree().get_nodes_in_group("selected")
	
	if selected[0].is_in_group("correct_looks") and selected[1].is_in_group("correct_looks"):
		
		submit_button.text = 'Correct'
		looks_ans.modulate.a = 255
		looks_correct = true
		await get_tree().create_timer(1).timeout
		submit_button.text = 'Submit'
		
	elif selected[0].is_in_group("correct_hair") and selected[1].is_in_group("correct_hair"):
		
		submit_button.text = 'Correct'
		hair_ans.modulate.a = 255
		hair_correct = true
		await get_tree().create_timer(1).timeout
		submit_button.text = 'Submit'
		
	elif selected[0].is_in_group("correct_color_clothes") and selected[1].is_in_group("correct_color_clothes"):
		
		submit_button.text = 'Correct'
		clothes_color_ans.modulate.a = 255
		clothes_color_correct = true
		await get_tree().create_timer(1).timeout
		submit_button.text = 'Submit'
		
	elif selected[0].is_in_group("correct_type_clothes") and selected[1].is_in_group("correct_type_clothes"):
		
		submit_button.text = 'Correct'
		clothes_type_ans.modulate.a = 255
		clothes_type_correct = true
		await get_tree().create_timer(1).timeout
		submit_button.text = 'Submit'
		
	elif selected[0].is_in_group("correct_hat") and selected[1].is_in_group("correct_hat"):
		
		submit_button.text = 'Correct'
		hat_ans.modulate.a = 255
		hat_correct = true
		await get_tree().create_timer(1).timeout
		submit_button.text = 'Submit'

	else:
		submit_button.text = 'Incorrect'
		await get_tree().create_timer(1).timeout
		submit_button.text = 'Submit'
		
	for select in selected:
		select.select_line.visible = false
		select.is_select = false
		select.remove_from_group("selected")
