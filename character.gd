extends CharacterBody2D
## Describe base character movement and mechanics

## Character max health
@export_range(1, 1, 1, "or_greater") var max_health: int = 100
## Current count of keys, character use key to open doors
@export_range(0, 0, 1, "or_greater") var key_count: int = 0

## Current health, set to max_health at start
var health: int = max_health

@onready var sprite: AnimatedSprite2D = $Sprite


func _process(delta: float) -> void:
	var movement_vector: Vector2 = Vector2.ZERO
	movement_vector.x = Input.get_axis("walk_left", "walk_right")
	movement_vector.y  = Input.get_axis("walk_up", "walk_down")
	
	if movement_vector.x < 0:
		sprite.play("walk_left")
	elif movement_vector.x > 0:
		sprite.play("walk_right")
	elif movement_vector.y < 0:
		sprite.play("walk_up")
	elif movement_vector.y > 0:
		sprite.play("walk_down")
	else:
		sprite.play("wait")
	
	move_and_collide(movement_vector.normalized() * delta * 100)
