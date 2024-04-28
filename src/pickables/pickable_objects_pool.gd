class_name PickableObjectsPool
extends Node2D
## Simple pool of scene objects, store object position and it state, reload unused objects and delete used.

## Get current parent scene path, needed to correct object save
@onready var _parent_path: String = get_parent().get_path()


func _ready() -> void:
	Globals.local_save.connect(_save_objects)
	if _parent_path in Globals.objects_data \
			and not Globals.objects_data[_parent_path].is_empty():
		_load_objects()
	else:
		_save_objects()


## Unvalid pickup object
func check_object(object: PickableObject):
	Globals.objects_data[_parent_path].merge({ 
		object.position : {
			"valid" : false,
			"resource" : object.pickable_resource,
		},
	}, true )


## Initialize objects dictionary
func _save_objects():
	for object in get_children():
		if object is PickableObject:
			if not _parent_path in Globals.objects_data:
				Globals.objects_data.merge({ _parent_path : {} }, true)
			
			Globals.objects_data[_parent_path].merge({ 
				object.position : {
					"valid" : true,
					"resource" : object.pickable_resource,
				},
			}, true )


## Load unused objects
func _load_objects():
	var path_dictionary: Dictionary = Globals.objects_data[_parent_path].duplicate()
	
	# Delete used object from base scene
	for object in get_children():
		if (
			object is PickableObject
			and object.position in path_dictionary
		):
			if not path_dictionary[object.position]["valid"]:
				object.queue_free()
			path_dictionary.erase(object.position)
	
	# Recheck unused objects
	for object_position in path_dictionary:
		if path_dictionary[object_position]["valid"]:
			Globals.drop_item(path_dictionary[object_position]["resource"], object_position, self)
