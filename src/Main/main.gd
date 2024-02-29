extends CanvasLayer

var file_button_functions = [
	'open_file',
	'save_file',
	'save_file_as',
	'quit',
]

var current_file = null

@onready var file_button = $VBoxContainer/MenuBar/FileButton

@onready var text_edit = $VBoxContainer/TextEdit

@onready var open_file_dialog = $OpenFileDialog
@onready var save_file_dialog = $SaveFileDialog

func open_file():
	open_file_dialog.popup_centered(Vector2(400, 400))

func save_file():
	if current_file:
		FileAccess.open(current_file, FileAccess.WRITE).store_string(text_edit.text)
	else:
		save_file_as()

func save_file_as():
	save_file_dialog.popup_centered(Vector2(400, 400))

func quit():
	get_tree().quit()

func _ready():
	# connecting menubar buttons
	file_button.get_popup().id_pressed.connect(_file_item_pressed)

func _file_item_pressed(id):
	call(file_button_functions[id])

func _on_open_file_dialog_file_selected(path):
	print(path)
	current_file = path
	text_edit.text = FileAccess.open(path, FileAccess.READ).get_as_text()

func _on_save_file_dialog_file_selected(path):
	current_file = path
	FileAccess.open(path, FileAccess.WRITE).store_string(text_edit.text)
