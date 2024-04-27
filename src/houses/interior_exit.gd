extends Area2D


## Outdoor street scene, switch to this scene after exit a house
@export var outdoor_path: String


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Globals.local_save.emit()
		var scene = ResourceLoader.load(outdoor_path)
		get_tree().call_deferred("change_scene_to_packed", scene)
