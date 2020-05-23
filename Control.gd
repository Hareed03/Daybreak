extends Control


func _ready():
	$MarginContainer/VBoxContainer.grab_focus()

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/StartGameButton.is_hovered() == true:
		$MarginContainer/VBoxContainer/StartGameButton.grab_focus()
	if $MarginContainer/VBoxContainer/QuitGameButton.is_hovered() == true:
		$MarginContainer/VBoxContainer/QuitGameButton.grab_focus()


func _on_StartGameButton_pressed():
	get_tree().change_scene("res://Singleplayer.tscn")
	
func _on_QuitGameButton_pressed():
	get_tree().quit()
