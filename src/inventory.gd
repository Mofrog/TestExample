extends CanvasLayer
## Base inventory class, can be used for character or local objects

## Base maximum inventory size
@export_range(0, 1, 1, "or_greater") var inventory_size: int = Globals.character_inventory_size

## Current selected item
var _selected_item: PickableResource = null

@onready var grid: GridContainer = $Control/VBoxContainer/PanelContainer/ScrollContainer/GridContainer
@onready var lbl_name: Label = $Control/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/Name
@onready var lbl_desc: Label = $Control/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer2/Description
@onready var buttons_container: VBoxContainer = $Control/VBoxContainer/HBoxContainer/PanelContainer/ButtonsContainer
@onready var btn_use: Button = $Control/VBoxContainer/HBoxContainer/PanelContainer/ButtonsContainer/Use
@onready var btn_trash: Button = $Control/VBoxContainer/HBoxContainer/PanelContainer/ButtonsContainer/Trash


func _process(_delta: float) -> void:
	btn_use.disabled = _selected_item == null
	btn_trash.disabled = _selected_item == null


## Add cell to inventory, if item is null, add empty cell
func add_item(item: PickableResource) -> void:
	var button: Button = Button.new()
	button.custom_minimum_size = Vector2(50, 50)
	button.expand_icon = true
	
	if item != null:
		button.icon = item.icon
	
	button.focus_entered.connect(_select_button.bind(item))
	grid.add_child(button)


## Select inventory cell
func _select_button(item: PickableResource):
	if item == null:
		lbl_name.text = "Пусто"
		lbl_desc.text = "Пустая ячейка"
	else:
		lbl_name.text = item.name
		lbl_desc.text = item.description
	
	_selected_item = item


## Update inventory cells
func _on_visibility_changed() -> void:
	if grid == null:
		return
	
	for child in grid.get_children():
		child.queue_free()
	
	for item in Globals.inventory_data:
		if grid.get_child_count() < inventory_size:
			add_item(item)
	
	for i in inventory_size - grid.get_child_count():
		add_item(null)


## Use selected item
func _on_use_pressed() -> void:
	if _selected_item != null:
		_selected_item.set_effect(Globals.character_link)
		Globals.inventory_data.erase(_selected_item)
		_selected_item = null
		visible = false
		Globals.block_character_movement = false


func _on_trash_pressed() -> void:
	if _selected_item != null:
		var drop_position: Vector2 = Globals.character_link.position
		drop_position.x += randf_range(25, 50)
		var scene = Globals.character_link.get_parent()
		Globals.drop_item(_selected_item, drop_position, scene)
		
		Globals.inventory_data.erase(_selected_item)
		_selected_item = null
		visible = false
		Globals.block_character_movement = false
