extends CanvasLayer

var file_button_functions = [
	'open_file',
	'save_file',
	'save_file_as',
	'quit',
]

@onready var file_button = $VBoxContainer/MenuBar/FileButton

func open_file():
	print(0)

func save_file():
	print(1)

func save_file_as():
	print(2)

func quit():
	get_tree().quit()

func _ready():
	# connecting menubar buttons
	file_button.get_popup().id_pressed.connect(_file_item_pressed)

func _file_item_pressed(id):
	call(file_button_functions[id])
