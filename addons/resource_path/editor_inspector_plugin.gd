extends EditorInspectorPlugin

const ResourcePathEditorProperty := preload("res://addons/resource_path/editor_property.gd")


func _can_handle(_object: Object) -> bool:
	return true


func _is_class(name: String):
	if ClassDB.class_exists(name):
		return true

	for item in ProjectSettings.get_global_class_list():
		if item.get("class") == name:
			return true

	return false


func _parse_property(_object: Object, _type: Variant.Type, name: String,
		hint_type: PropertyHint, hint_string: String, _usage_flags: int, _wide: bool) -> bool:
	if hint_type == PROPERTY_HINT_FILE and _is_class(hint_string):
		add_property_editor(name, ResourcePathEditorProperty.new(hint_string))
		return true
	return false
