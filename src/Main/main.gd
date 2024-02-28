extends CanvasLayer

@onready var file_button = $VBoxContainer/MenuBar/FileButton

func _ready():
	file_button.get_popup().connect("pressed", self, "_file_item_pressed")
	#file_button.get_popup().connect(_file_item_presses())

func _file_item_pressed(id):
	print(id)
