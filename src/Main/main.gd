extends CanvasLayer

@onready var file_button = $VBoxContainer/MenuBar/FileButton

func _ready():
	# connecting menubar buttons
	file_button.get_popup().id_pressed.connect(_file_item_pressed)

func _file_item_pressed(id):
	print(id)
