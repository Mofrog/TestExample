class_name PickableHealth
extends PickableResource
## Add or subtract character health

## Add or subtract character health
@export var health_count: int = 0
## Add or subtract character max health
@export var max_health_count: int = 0


## Extend method in child class for activate effect
func set_effect(character: CharacterBody2D) -> void:
	if character.get("max_health") != null:
		character.max_health += max_health_count
	if character.get("health") != null:
		character.health += health_count
