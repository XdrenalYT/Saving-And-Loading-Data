extends Control

var save_file_path = "user://save/"
var save_file_name = "GoalSave.tres"


var rectPreload = preload("res://Main/Home/GoalRect.tscn")

var submitted_name = false
var submitted_date = false

var goalData = GoalData.new()
var goalAmount = 0


func _ready():
	verify_save_directory(save_file_path)

func verify_save_directory(path:String):
	DirAccess.make_dir_absolute(path)


#Creating Goals#############################################################
func _on_add_pressed():
	$bg2.visible = true


func _on_goal_name_edit_text_submitted(new_text):
	submitted_name = true
	if submitted_date:
		create_new_goal()
		submitted_name = false
		submitted_date = false


func _on_goal_name_edit_2_text_submitted(new_text):
	submitted_date = true
	if submitted_name:
		create_new_goal()
		submitted_name = false
		submitted_date = false

func create_new_goal():
	$bg2.visible = false
	var new_rect = rectPreload.instantiate()
	$ScrollContainer/VBoxContainer.add_child(new_rect)
	new_rect.onDeleteGoal.connect(delete_goal)
	var new_goal_resource = GoalResource.new()
	new_goal_resource.goal_name = $bg2/GoalNameEdit.text
	new_goal_resource.date = $bg2/GoalNameEdit2.text
	new_rect.update_labels(new_goal_resource)
	goalData.add_goal(new_goal_resource)
	
	goalAmount += 1

######################################################################################

func delete_goal(goal_resource: GoalResource):
#	goalData.remove_goal(goal_resource)
	goalData.remove_goal(goal_resource)
	goalAmount -= 1
#	save()



func _on_load_button_pressed():
	load_data()

func load_data():
	goalData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	print(ResourceLoader.load(save_file_path + save_file_name)) 
	load_goals()

func save():
	print("Saving")
	ResourceSaver.save(goalData, save_file_path + save_file_name)
	print(ResourceSaver.save(goalData, save_file_path + save_file_name))	

func load_goals():
	for child in $ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
	for goal in goalData.goals:
		print("loading goals")
		var new_rect = rectPreload.instantiate()
		$ScrollContainer/VBoxContainer.add_child(new_rect)
		new_rect.onDeleteGoal.connect(delete_goal)
		new_rect.update_labels(goal)


func _on_save_button_pressed():
	save()
