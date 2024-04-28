extends Node


## Close all houses in current scene
signal close_doors()

## Save all objects in game
signal local_save()

## Print custom message in HUD
signal print_message(message: String)


## Block all character movement inputs and interactions
var block_character_movement: bool = false

## Current character link, used for prevent spawn dublicates
var character_link: CharacterBody2D = null

## Saved character data
var character_data: Dictionary = {}

## Store character inventory data
var inventory_data: Array[PickableResource] = []

## Maximum character inventory size
var character_inventory_size: int = 4

## This position used for spawn character near last entered house
var current_house_spawn_point: Vector2 = Vector2.ZERO

## Store all saved game houses data
var houses_data: Dictionary = {}

## Store all saved game objects data
var objects_data: Dictionary = {}


func _ready() -> void:
	var scene: PackedScene = ResourceLoader.load("res://src/hud.tscn")
	get_tree().root.add_child.call_deferred(scene.instantiate()) 


## Close all doors in game
func close_saved_doors() -> void:
	for house in houses_data.keys():
		houses_data.merge( { house : false }, true )
	close_doors.emit()


## Restart game, reset data and character
func restart_game() -> void:
	houses_data.clear()
	objects_data.clear()
	current_house_spawn_point = Vector2.ZERO
	character_data.clear()
	inventory_data.clear()
	character_link = null
	var scene = ResourceLoader.load("res://src/outdoor.tscn")
	get_tree().call_deferred("unload_current_scene")
	get_tree().call_deferred("change_scene_to_packed", scene)


## Append pickup item to character inventory
func add_object_to_inventory(item: PickableResource) -> void:
	inventory_data.append(item)


## Drop item at position
func drop_item(item: PickableResource, drop_position: Vector2, scene: Node2D) -> void:
	var object: PickableObject = PickableObject.new()
	object.pickable_resource = item
	object.position = drop_position
	
	var object_pool: Node2D = _find_object_pool(scene)
	object_pool.add_child(object)


## Find first object pool, or create new
func _find_object_pool(scene: Node2D) -> Node2D:
	if scene is PickableObjectsPool:
		return scene
	
	for child in scene.get_children():
		if child is PickableObjectsPool:
			return child
	
	var object_pool: Node2D = Node2D.new()
	var script: Script = ResourceLoader.load("res://src/pickables/pickable_objects_pool.gd")
	object_pool.set_script(script)
	scene.add_child(object_pool)
	
	return object_pool
