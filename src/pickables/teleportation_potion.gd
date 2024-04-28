class_name PickableTeleportationPotion
extends PickableResource
## Teleport character at custom distance

## Maximum and minimum radius of teleportation
@export_range(1.0, 1.0, 0.1, "or_greater", "hide_slider") var teleportation_radius: float = 50.0


## Extend method in child class for activate effect
func set_effect(_character: CharacterBody2D) -> void:
	var random_position: Vector2 = Vector2.ZERO
	random_position.x = randf_range(1.0, teleportation_radius)
	random_position.y = randf_range(1.0, teleportation_radius)
	_character.position += random_position
