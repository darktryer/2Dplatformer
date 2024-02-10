extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#double click implementation of the quit button
var last_click_time = 0
var previous_click_time = 0
func _on_quit_pressed():
	previous_click_time = last_click_time
	last_click_time = Time.get_ticks_msec()
	if (last_click_time - previous_click_time) < 500:
		get_tree().quit()
	

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes_and_scripts/startWorld/cave.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes_and_scripts/menu_option/gameOptions.tscn")
