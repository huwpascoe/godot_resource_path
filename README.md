# godot_resource_path
![icon](https://github.com/huwpascoe/godot_resource_path/blob/master/icon.png)

Need portals to other maps?
Got a circular dependency? Want to lazy-load resources?

Resource Paths makes it easy to select and load other resources by UID string.

```
# Specify a valid class name as an export_file argument
@export_file("PackedScene")
var destination_scene: String
```

![screenshot](https://github.com/huwpascoe/godot_resource_path/blob/master/screenshot.png)
