extends TileMap


## Activation message
@export_multiline var description: String = "Some text"

var _is_character_entered: bool = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and _is_character_entered:
		print(description)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		_is_character_entered = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		_is_character_entered = false
