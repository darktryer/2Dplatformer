extends OptionButton

func _ready():
	var resolutions = ["512x320", "1080x1120"]
	for i in resolutions: # Assuming we have defined 10 custom resolutions (resolution_1 to resolution_10)
		var setting_path = "/display/resolutions/resolution_" + str(i)
		if ProjectSettings.has_setting(setting_path): # Check if the resolution exists
			var resolution_str = ProjectSettings.get_setting(setting_path)
			resolutions.append(resolution_str)

	for resolution in resolutions:
		$".".add_item(resolution)

	$".".connect("item_selected", _on_resolution_selected)

func _on_resolution_selected(index):
	var selected_resolution = ProjectSettings.get_setting("/display/resolutions/resolution_" + str(index + 1)) # Adjust for 0-based index)
	var size_arr = selected_resolution.split("x")  # Split the resolution string into width and height
	var width = int(size_arr[0])
	var height = int(size_arr[1])
	ProjectSettings.set_setting("display/window/size", Vector2(width, height))  # Update the window size
	ProjectSettings.save()  # Save the updated settings
#get_tree().root.content_scale_factor
