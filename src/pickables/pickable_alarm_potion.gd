class_name PickableAlarmPotion
extends PickableResource


## Extend method in child class for activate effect
func set_effect(_character: CharacterBody2D) -> void:
	Globals.close_saved_doors()
