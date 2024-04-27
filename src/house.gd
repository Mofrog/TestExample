@tool
extends TileMap
## Outdoor part of house, character can open house with key and pass over it

## If house is open, character can pass over it without using a key
@export var is_open: bool = false

@onready var door: AnimatedSprite2D = $Door
## Character respawn point
@onready var spawn: Node2D = $Spawn


func _init() -> void:
	Globals.close_doors.connect(_on_close_doors)


func _process(_delta: float) -> void:
	if is_open:
		door.play("open")
	else:
		door.play("closed")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not is_open:
		if body is CharacterBody2D \
					and body.get("key_count") != null \
					and body.get("key_count") > 0:
			body.key_count -= 1
			is_open = true


func _on_close_doors():
	is_open = false
