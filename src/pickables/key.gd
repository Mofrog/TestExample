@tool
extends PickableObject
## Key class


## Extend method in child class for interaction with character
func interact_with(character: CharacterBody2D) -> void:
	if character.get("key_count") != null:
		character.key_count += 1
