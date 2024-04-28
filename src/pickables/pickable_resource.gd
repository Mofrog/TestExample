class_name PickableResource
extends Resource
## Base resource class of all pickable objects

## Pickable human readable name
@export var name: String
## Pickable human readable description
@export_multiline var description: String
## Pickable icon, used in HUD and in-game
@export var icon: Texture2D
## Is this object can be added to inventory
@export var is_can_add_to_inventory: bool = true
## Is this object will be deleted after use
@export var consumable: bool = true
## Is this object can be used by character
@export var usable: bool = true


## Extend method in child class for interaction with character
func interact_with(_character: CharacterBody2D) -> void:
	pass


## Extend method in child class for activate effect
func set_effect(_character: CharacterBody2D) -> void:
	pass
