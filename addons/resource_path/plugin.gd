@tool
extends EditorPlugin

const ResPathInspector = preload("res://addons/resource_path/inspector_plugin.gd")

var _inspector: ResPathInspector


func _enter_tree() -> void:
	_inspector = ResPathInspector.new()
	add_inspector_plugin(_inspector)


func _exit_tree() -> void:
	if _inspector:
		remove_inspector_plugin(_inspector)
