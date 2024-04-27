extends CanvasLayer
## Appear after attempt to open the door

## Return user answer
signal user_answer(answer: bool)


func _ready() -> void:
	Globals.block_character_movement = true


func _exit_tree() -> void:
	Globals.block_character_movement = false


func _on_btn_yes_pressed() -> void:
	user_answer.emit(true)
	queue_free()


func _on_btn_no_pressed() -> void:
	user_answer.emit(false)
	queue_free()
