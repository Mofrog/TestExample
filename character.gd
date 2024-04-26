extends CharacterBody2D
## Describe base character movement and mechanics

## Character max health
@export var max_health: int = 100
## Current count of keys
@export var key_count: int = 0

## Current health, set to max_health at start
var health: int = max_health

@onready var sprite: AnimatedSprite2D = $Sprite


func _process(_delta: float) -> void:
	var x = Input.get_axis("walk_left", "walk_right")
	var y = Input.get_axis("walk_up", "walk_down")
	
	if x < 0:
		sprite.play("walk_left")
	elif x > 0:
		sprite.play("walk_right")
	elif y < 0:
		sprite.play("walk_up")
	elif y > 0:
		sprite.play("walk_down")
	else:
		sprite.play("wait")
	
	position += Vector2(x, y).normalized()
