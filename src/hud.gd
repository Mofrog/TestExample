extends Control
## Base class of HUD elements

@onready var health: Label =  $PanelContainer/VBoxContainer/Health
@onready var key: Label = $PanelContainer/VBoxContainer/Key
@onready var hint_panel: PanelContainer = $PanelContainer2
@onready var hint: Label = $PanelContainer2/Hint
@onready var hint_timer: Timer = $PanelContainer2/HintTimer


func _ready() -> void:
	Globals.print_message.connect(_on_print_message)


func _process(_delta: float) -> void:
	var character: CharacterBody2D = Globals.character_link
	if character != null:
		health.text = str("HP : ", character.health, " / ", character.max_health)
		key.text = str("Ключи : ", character.key_count)


func _on_print_message(message: String) -> void:
	hint_panel.visible = true
	hint.text = message
	hint_timer.start()


func _on_hint_timer_timeout() -> void:
	hint_panel.visible = false
