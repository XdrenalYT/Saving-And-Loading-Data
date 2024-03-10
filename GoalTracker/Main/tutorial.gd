extends Control

var save_file_path = "user://save/"
var save_file_name = "NumsSave.tres"

var numberData = NumData.new()


@onready var save_button = $SaveButton
@onready var load_button = $LoadButton
@onready var label = $Label

@export var min: int
@export var max: int


func _ready():
	verify_save_directory(save_file_path)

func verify_save_directory(path:String):
	DirAccess.make_dir_absolute(path)


func _on_add_num_button_pressed():
	#adds random number from min to max
	randomize()
	
	numberData.numbers.append(randi_range(min,max))
	update_label()

func update_label():
	label.text = str(numberData.numbers)




func _on_load_button_pressed():
	print("loading")
	numberData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	update_label()


func _on_save_button_pressed():
	print("Saving")
	ResourceSaver.save(numberData, save_file_path + save_file_name)
