extends Node2D


func _ready() -> void:
	Globals.local_save.connect(_on_local_save)
	if get_path() in Globals.objects_data \
			and not Globals.objects_data[get_path()].is_empty():
		_load_objects()
	else:
		_save_objects()


## Initialize objects dictionary
func _save_objects():
	for object in get_children():
		if object is PickableObject:
			if not get_path() in Globals.objects_data:
				Globals.objects_data.merge({ get_path() : {} }, true)
			
			Globals.objects_data[get_path()].merge( { object.position : true }, true )


## Delete all used objects
func _load_objects():
	var path_dictionary: Dictionary = Globals.objects_data[get_path()]
	
	for object in get_children():
		if object is PickableObject \
				and object.position in path_dictionary \
				and not path_dictionary[object.position]:
			object.queue_free()


## Save scene objects state
func _on_local_save() -> void:
	var path_dictionary: Dictionary = Globals.objects_data[get_path()]
	
	for object in path_dictionary:
		path_dictionary.merge( { object : false }, true )
	
	for object in get_children():
		if object is PickableObject:
			path_dictionary.merge( { object.position : true }, true )
