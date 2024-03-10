extends ColorRect

var goalResource: GoalResource

@onready var goal_name_label = $GoalNameLabel
@onready var date_label = $DateLabel

signal buttonClicked(button)
signal onDeleteGoal(resource: GoalResource)

func update_labels(resource):
	goalResource = resource
	goal_name_label.text = goalResource.goal_name
	date_label.text = goalResource.date
	



func _on_button_pressed():
	emit_signal("buttonClicked", self)


func _on_check_button_pressed():
	emit_signal("onDeleteGoal", goalResource)
	queue_free()
