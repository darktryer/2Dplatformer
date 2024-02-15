extends Node2D
#var windowResize = preload("res://scenes_and_scripts/menu_option/windowResize.gd")
@onready var soundsValueNumberLabel = $CanvasLayer/ColorRect/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/soundValueNumber
@onready var musicValueNumberLabel = $CanvasLayer/ColorRect/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer3/musicValueNumber

# Called when the node enters the scene tree for the first time.
func _ready():
	var currentResolution = get_viewport().get_size()
	print(currentResolution)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes_and_scripts/menu/menu.tscn")


func _on_sound_value_slider_value_changed(value):
	soundsValueNumberLabel.text = str(value) + "%"


func _on_music_value_slider_value_changed(value):
	musicValueNumberLabel.text = str(value) + "%"
