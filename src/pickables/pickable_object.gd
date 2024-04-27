@tool
class_name PickableObject
extends Node2D
## Base class of all pickable objects, do nothing by default

## Resource of pickable
@export var pickable_resource: PickableResource

var sprite: Sprite2D = null


## Initialize base pickable object nodes
func _init() -> void:
	sprite = Sprite2D.new()
	
	var area: Area2D = Area2D.new()
	area.body_entered.connect(_on_area_2d_body_entered)
	
	var collision: CollisionShape2D = CollisionShape2D.new()
	collision.shape = CircleShape2D.new()
	
	area.add_child(collision)
	sprite.add_child(area)
	add_child(sprite)


func _process(_delta: float) -> void:
	if pickable_resource != null:
		sprite.texture = pickable_resource.icon


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		interact_with(body)
		queue_free()


## Extend method in child class for interaction with character
func interact_with(_character: CharacterBody2D) -> void:
	pass
