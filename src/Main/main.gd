extends CanvasLayer

var file_button_functions = [
	'new_file',
	'open_file',
	'save_file',
	'save_file_as',
	'quit',
]

var help_button_functions = [
	'show_about'
]

var current_file = null

@onready var file_button = $VBoxContainer/MenuBar/FileButton
@onready var help_button = $VBoxContainer/MenuBar/HelpButton

@onready var text_edit = $VBoxContainer/TextEdit

@onready var open_file_dialog = $OpenFileDialog
@onready var save_file_dialog = $SaveFileDialog
@onready var about_window = $AboutWindow

func _ready():
	# connecting menubar buttons
	file_button.get_popup().id_pressed.connect(_file_item_pressed)
	help_button.get_popup().id_pressed.connect(_help_item_pressed)
	DisplayServer.window_set_title('Simple Text Editor - Untitled')

func update_window_title():
	if current_file:
		DisplayServer.window_set_title('Simple Text Editor - ' + str(current_file))
	else:
		DisplayServer.window_set_title('Simple Text Editor - Untitled')

func show_about():
	about_window.popup_centered(Vector2(400, 200))

func new_file():
	current_file = null
	update_window_title()
	text_edit.text = ''

func open_file():
	open_file_dialog.popup_centered(Vector2(400, 400))

func save_file():
	if current_file:
		var f = FileAccess.open(current_file, FileAccess.WRITE)
		f.store_string(text_edit.text)
		f.close()
	else:
		save_file_as()

func save_file_as():
	save_file_dialog.popup_centered(Vector2(400, 400))

func quit():
	get_tree().quit()

func _file_item_pressed(id):
	call(file_button_functions[id])

func _on_open_file_dialog_file_selected(path):
	current_file = path
	update_window_title()
	var f = FileAccess.open(path, FileAccess.READ)
	text_edit.text = f.get_as_text()
	f.close()

func _on_save_file_dialog_file_selected(path):
	current_file = path
	update_window_title()
	var f = FileAccess.open(path, FileAccess.WRITE)
	f.store_string(text_edit.text)
	f.close()
	
func _help_item_pressed(id):
	call(help_button_functions[id])

func _on_about_window_close_requested():
	about_window.hide()
