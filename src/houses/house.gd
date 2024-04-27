@tool
extends TileMap
## Outdoor part of house, character can open house with key and pass over it

## If house is open, character can pass over it without using a key
@export var is_open: bool = false
## House interior scene, switch to this scene after open the door by character
@export var house_interior_path: String

@onready var door: AnimatedSprite2D = $Door
## Character respawn point
@onready var spawn: Node2D = $SpawnPoint


func _init() -> void:
	Globals.close_doors.connect(_on_close_doors)
	Globals.local_save.connect(_on_local_save)


func _ready() -> void:
	if global_position in Globals.houses_data:
		is_open = Globals.houses_data[global_position]


func _process(_delta: float) -> void:
	if is_open and not house_interior_path.is_empty():
		door.play("open")
	else:
		door.play("closed")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return
	
	if not is_open \
			and body.get("key_count") != null \
			and body.get("key_count") > 0 \
			and not house_interior_path.is_empty():
		body.key_count -= 1
		is_open = true
	_enter_the_house()


## Change scene to house interior
func _enter_the_house():
	if is_open:
		Globals.local_save.emit()
		Globals.current_house_spawn_point = spawn.global_position
		var scene = ResourceLoader.load(house_interior_path)
		get_tree().call_deferred("change_scene_to_packed", scene)


func _on_close_doors():
	is_open = false


func _on_local_save():
	Globals.houses_data.merge( { global_position : is_open }, true )
