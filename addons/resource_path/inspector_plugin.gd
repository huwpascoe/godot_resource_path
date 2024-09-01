extends EditorInspectorPlugin

const ResPathEditorProperty = preload("res://addons/resource_path/editor_property.gd")


func _can_handle(object: Object) -> bool:
	return true


func _parse_property(object: Object, type: Variant.Type, name: String,
	hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:

	if hint_type == PROPERTY_HINT_FILE and ClassDB.class_exists(hint_string):
		add_property_editor(name, ResPathEditorProperty.new(hint_string))
		return true

	return false
