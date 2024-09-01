extends Button

# Specify a valid class name as an export_file argument
@export_file("PackedScene")
var destination_scene: String


func _on_pressed() -> void:
	var err := get_tree().change_scene_to_file(destination_scene)

	if err != OK:
		print(error_string(err))
