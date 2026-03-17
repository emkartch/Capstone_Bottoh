extends CenterContainer

@onready var item_data = self.get_meta('item_data')
@onready var r_arrow = $"OpenItemTexture/R Arrow"
@onready var l_arrow = $"OpenItemTexture/L Arrow"
@onready var open_item_texture = $OpenItemTexture
#@onready var inventory_container = $"../../../InventoryContainer"

#@onready var notebook_appearance = preload("res://inventory/pages/notebook/notebook_appearance.tscn")
#@onready var notebook_clothes = preload("res://inventory/pages/notebook/notebook_clothes.tscn")
#@onready var notebook_colors = preload("res://inventory/pages/notebook/notebook_colors.tscn")
#@onready var notebook_hats = preload("res://inventory/pages/notebook/notebook_hats.tscn")

@onready var note_questions = preload("res://inventory/pages/note/note_qcontainer.tscn")

var pick_checked = false

#var group_type = null
#var select_group_type = null

var margins = 128

var basic_x = null

var basic_y = null

var basic_button_x = null

var basic_button_y = null

var basic_arrow_x = null

var basic_arrow_y = null

var curr_page = 1

var appearance = null
var clothes = null
var colors = null
var hats = null

var notebook_title = null
var page_number = null

var questions = null

var exiting = false

func _ready():
	
	if item_data.pages > 1:
		r_arrow.visible = true
		l_arrow.visible = false
	else:
		r_arrow.visible = false
		l_arrow.visible = false
	
	if item_data.item_name == "Notebook":
		
		var VBox = VBoxContainer.new()
		
		var HBox = HBoxContainer.new()
		
		notebook_title = Label.new()
		
		page_number = Label.new()
		
		notebook_title.text = "Appearance"
		notebook_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		notebook_title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		notebook_title.size_flags_horizontal = Control.SIZE_EXPAND | Control.SIZE_FILL
		
		page_number.text = "1/4"
		page_number.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		page_number.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		page_number.add_theme_font_size_override("font_size",40)
		
		VBox.size = Vector2(580,600)
		
		VBox.pivot_offset = VBox.size / 2
		
		VBox.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		VBox.set_offsets_preset(Control.PRESET_CENTER,Control.PRESET_MODE_KEEP_SIZE,0)
		
		VBox.set_anchors_preset(Control.PRESET_CENTER)
		#move down ~15
		VBox.position.y -= 15
		
		HBox.add_theme_constant_override("Separation",0)
		
		VBox.add_theme_constant_override("Separation",0)
		
		open_item_texture.add_child(VBox)
		
		appearance = Global.notebook_appearance
		clothes = Global.notebook_clothes
		colors = Global.notebook_colors
		hats = Global.notebook_hats
		
		appearance.visible = true
		clothes.visible = false
		colors.visible = false
		hats.visible = false
		
		HBox.add_child(notebook_title)
		HBox.add_child(page_number)
		
		VBox.add_child(HBox)
		
		VBox.add_child(appearance)
		VBox.add_child(clothes)
		VBox.add_child(colors)
		VBox.add_child(hats)
		
	elif item_data.item_name == "Note":
		
		if Global.note_questions == null:
			
			Global.note_questions = note_questions.instantiate()
		
		questions = Global.note_questions
		
		questions.size = Vector2(0,0)
		
		questions.position = Vector2(80,45)
		
		questions.pivot_offset = questions.size / 2
		
		questions.set_offsets_preset(Control.PRESET_CENTER,Control.PRESET_MODE_KEEP_SIZE,0)
		
		questions.set_anchors_preset(Control.PRESET_CENTER)
		
		open_item_texture.add_child(questions)
		
		Global.looks_ans = questions.get_node("Looks ENG")
		Global.hair_ans = questions.get_node("Hair ENG")
		Global.clothes_color_ans = questions.get_node("Clothes ENG/Clothes Color ENG")
		Global.clothes_type_ans = questions.get_node("Clothes ENG/Clothes Type ENG")
		Global.hat_ans = questions.get_node("Hat ENG")

func _on_r_arrow_pressed() -> void:
	
	curr_page += 1
	
	for page in range(item_data.pages - 1):
		
		if curr_page == item_data.pages:
			l_arrow.visible = true
			r_arrow.visible = false
		else:
			l_arrow.visible = true
			r_arrow.visible = true
	
	if item_data.item_name == "Notebook":
		
		if curr_page == 2:
			
			appearance.visible = false
			clothes.visible = true
			
			notebook_title.text = "Clothes"
			page_number.text = "2/4"
			
		elif curr_page == 3:
			
			clothes.visible = false
			colors.visible = true
			
			notebook_title.text = "Colors"
			page_number.text = "3/4"
			
		elif curr_page == 4:
			
			colors.visible = false
			hats.visible = true
			
			notebook_title.text = "Hats"
			page_number.text = "4/4"
	
	elif item_data.item_name == "Newspaper":
		
		if curr_page == 2:
			
			open_item_texture.texture = item_data.item[1]

func _on_l_arrow_pressed() -> void:
	
	curr_page -= 1
	
	for page in range(item_data.pages - 1):
		
		if curr_page == 1:
			l_arrow.visible = false
			r_arrow.visible = true
		else:
			l_arrow.visible = true
			r_arrow.visible = true
	
	if item_data.item_name == "Notebook":
		
		if curr_page == 1:
			
			appearance.visible = true
			clothes.visible = false
			
			notebook_title.text = "Appearance"
			page_number.text = "1/4"
			
		elif curr_page == 2:
			
			clothes.visible = true
			colors.visible = false
			
			notebook_title.text = "Clothes"
			page_number.text = "2/4"
			
		elif curr_page == 3:
			
			colors.visible = true
			hats.visible = false
			
			notebook_title.text = "Colors"
			page_number.text = "3/4"
	
	elif item_data.item_name == "Newspaper":
		
		if curr_page == 1:
			
			open_item_texture.texture = item_data.item[0]
