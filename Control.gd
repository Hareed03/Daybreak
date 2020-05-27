extends Control

var scene_path_to_load

func _ready():
	for button in $HBoxContainer/buttons.get_children():
		button.connect("pressed", self, "_on_Button_Pressed", button.scene_to_load)

func _on_Button_Pressed(scene_to_load):
	get_tree().change_scene("res://Singleplayer.tscn")
	
func _on_QuitGameButton_pressed():
	get_tree().quit()
