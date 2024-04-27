extends Node2D

## Set this spawn point to default, can be only one spawn point by default by scene
@export var default_spawn_point: bool = false
## Set this spawn point to ignore last house spawn point, usable in interior scenes
@export var interior_spawn_point: bool = false
## Base character to spawn
@export var character: PackedScene = preload("res://src/character.tscn")


func _ready() -> void:
	if default_spawn_point and Globals.character_link == null:
		load_character()


## Load character from data, if data is empty, creates a new character
func load_character() -> void:
	var character_instance = character.instantiate()
	
	# Set position of character spawn
	if Globals.current_house_spawn_point != Vector2.ZERO \
			and not interior_spawn_point:
		character_instance.position = Globals.current_house_spawn_point
		Globals.current_house_spawn_point = Vector2.ZERO
	else:
		character_instance.position = position
	
	if not Globals.character_data.is_empty():
		character_instance.max_health = Globals.character_data["max_health"]
		character_instance.key_count = Globals.character_data["key_count"]
		character_instance.health = Globals.character_data["health"]
	
	get_parent().add_child.call_deferred(character_instance)
	Globals.character_link = character_instance
