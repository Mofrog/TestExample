extends Node


## Close all houses in current scene
signal close_doors()

## Save all objects in game
signal local_save()

## Current character link, used for prevent spawn dublicates
var character_link: CharacterBody2D = null

## Saved character data
var character_data: Dictionary = {}

## This position used for spawn character near last entered house
var current_house_spawn_point: Vector2 = Vector2.ZERO

## Saved all game houses data
var houses_data: Dictionary = {}


## Close all doors in game
func close_saved_doors():
	for house in houses_data.keys():
		houses_data.merge( { house : false }, true )
		close_doors.emit()
