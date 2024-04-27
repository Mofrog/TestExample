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
	houses_data = {}
	objects_data = {}
	current_house_spawn_point = Vector2.ZERO
	character_data = {}
	character_link = null
	var scene = ResourceLoader.load("res://src/outdoor.tscn")
	get_tree().call_deferred("unload_current_scene")
	get_tree().call_deferred("change_scene_to_packed", scene)
