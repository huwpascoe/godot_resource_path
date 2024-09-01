extends EditorInspectorPlugin

const ResourcePathEditorProperty := preload("res://addons/resource_path/editor_property.gd")


func _can_handle(_object: Object) -> bool:
	return true


func _parse_property(_object: Object, _type: Variant.Type, name: String,
		hint_type: PropertyHint, hint_string: String, _usage_flags: int, _wide: bool) -> bool:
	if hint_type == PROPERTY_HINT_FILE and ClassDB.class_exists(hint_string):
		add_property_editor(name, ResourcePathEditorProperty.new(hint_string))
		return true
	return false
