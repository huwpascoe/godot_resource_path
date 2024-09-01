@tool
extends EditorPlugin

const ResourcePathInspectorPlugin := preload("res://addons/resource_path/editor_inspector_plugin.gd")

var _inspector: ResourcePathInspectorPlugin


func _enter_tree() -> void:
	_inspector = ResourcePathInspectorPlugin.new()
	add_inspector_plugin(_inspector)


func _exit_tree() -> void:
	if _inspector:
		remove_inspector_plugin(_inspector)
