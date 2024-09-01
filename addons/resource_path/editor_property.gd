extends EditorProperty

var _picker := EditorResourcePicker.new()
var _current_path: String

func _init(p_base_type: String):
	_picker.base_type = p_base_type
	_picker.resource_changed.connect(_resource_changed)
	_picker.resource_selected.connect(_resource_selected)
	add_child(_picker)


func _pick(p_path: String):
	if ResourceLoader.exists(p_path, _picker.base_type):
		_picker.edited_resource = ResourceLoader.load(p_path)
	else:
		_picker.edited_resource = null


func _update_property() -> void:
	var path: String = get_edited_object()[get_edited_property()]
	if _current_path != path:
		_current_path = path
		_pick(path)


func _resource_changed(resource: Resource):
	if resource == null:
		return

	if ResourceLoader.exists(resource.resource_path, _picker.base_type):
		var id := ResourceLoader.get_resource_uid(resource.resource_path)
		if id != ResourceUID.INVALID_ID:
			emit_changed(get_edited_property(), ResourceUID.id_to_text(id))
		else:
			push_warning("UID missing for %s, defaulting to res://" % resource.resource_name)
			emit_changed(get_edited_property(), resource.resource_path)
	else:
		_pick(_current_path)
		push_error("Property \"%s\" must be assigned a resource with a filename." % label)


func _resource_selected(resource: Resource, inspect: bool):
	EditorInterface.edit_resource.call_deferred(resource)
