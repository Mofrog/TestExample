@tool
extends PickableObject


## Extend method in child class for interaction with character
func interact_with(character: CharacterBody2D) -> void:
	if character.get("health") != null:
		character.health -= 1
