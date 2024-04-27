@tool
extends PickableObject


## Extend method in child class for interaction with character
func interact_with(character: CharacterBody2D) -> void:
	if character.get("max_health"):
		character.max_health -= 10
