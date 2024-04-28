extends CanvasLayer
## Base class of HUD elements

@onready var health: Label = $Hud/PanelContainer/VBoxContainer/Health
@onready var key: Label = $Hud/PanelContainer/VBoxContainer/Key
@onready var hint_panel: PanelContainer = $Hud/PanelContainer2
@onready var hint: Label = $Hud/PanelContainer2/Hint
@onready var hint_timer: Timer = $Hud/PanelContainer2/HintTimer
@onready var inventory: CanvasLayer = $Inventory


func _ready() -> void:
	Globals.print_message.connect(_on_print_message)


func _process(_delta: float) -> void:
	var character: CharacterBody2D = Globals.character_link
	if character != null:
		health.text = str("HP : ", character.health, " / ", character.max_health)
		key.text = str("Ключи : ", character.key_count)
	
	if Input.is_action_just_pressed("open_inventory"):
		if inventory.visible:
			inventory.visible = false
		else:
			inventory.visible = true
		
		Globals.block_character_movement = inventory.visible


func _on_print_message(message: String) -> void:
	hint_panel.visible = true
	hint.text = message
	hint_timer.start()


func _on_hint_timer_timeout() -> void:
	hint_panel.visible = false
