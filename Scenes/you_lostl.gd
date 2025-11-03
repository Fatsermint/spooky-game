extends Control

@onready var label: Label = $TextureRect/Label

@onready var tryAgain: Label = $TextureRect2/Label
@onready var backToMainMenu: Label = $TextureRect3/Label
signal TryAgain
signal Mainmenu
# try again
func _on_button_pressed() -> void:
	TryAgain.emit()
	label.text = "You lost!"
	


func _on_mainMenu_button_pressed() -> void:
	Mainmenu.emit()
	label.text = "You lost!"


func _on_player_win() -> void:
	label.text = "You won!"
