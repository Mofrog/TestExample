class_name PickableKey
extends PickableResource
## Add key to character

@export var key_count: int = 0


## Extend method in child class for interaction with character
func interact_with(character: CharacterBody2D) -> void:
	if character.get("key_count") != null:
		character.key_count += key_count
