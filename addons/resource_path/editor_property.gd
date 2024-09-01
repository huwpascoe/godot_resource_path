extends EditorProperty

const NoCreateEditorResourcePicker := preload("res://addons/resource_path/editor_resource_picker.gd")

var _picker := NoCreateEditorResourcePicker.new()
var _current_path: String


func _init(base_type: String) -> void:
	_picker.base_type = base_type
	_picker.resource_changed.connect(_on_resource_changed)
	_picker.resource_selected.connect(_on_resource_selected)
	add_child(_picker)


func _update_property() -> void:
	var path: String = get_edited_object()[get_edited_property()]
	if _current_path != path:
		_current_path = path
		_pick(path)


func _pick(path: String) -> void:
	if ResourceLoader.exists(path, _picker.base_type):
		_picker.edited_resource = ResourceLoader.load(path)
	else:
		_picker.edited_resource = null


func _on_resource_changed(resource: Resource) -> void:
	if not resource:
		return

	if ResourceLoader.exists(resource.resource_path, _picker.base_type):
		var id: int = ResourceLoader.get_resource_uid(resource.resource_path)
		if id != ResourceUID.INVALID_ID:
			emit_changed(get_edited_property(), ResourceUID.id_to_text(id))
		else:
			push_warning("UID missing for %s, defaulting to res://" % resource.resource_name)
			emit_changed(get_edited_property(), resource.resource_path)
	else:
		_pick(_current_path)
		push_error('Property "%s" must be assigned a resource with a filename.' % label)


func _on_resource_selected(resource: Resource, _inspect: bool) -> void:
	EditorInterface.edit_resource.call_deferred(resource)
