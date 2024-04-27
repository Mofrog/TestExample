@tool
extends PickableObject


## Extend method in child class for interaction with character
func interact_with(_character: CharacterBody2D) -> void:
	Globals.close_doors.emit()
