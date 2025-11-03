extends Control

@onready var label: Label = $TextureRect/Label
@onready var labelmode: Label = $TextureRect3/Label
@onready var you_lost: Control = self

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
	you_lost.visible = false


func _on_player_win() -> void:
	label.text = "You won!"
	you_lost.visible = true


func _on_starting_menu_easy() -> void:
	labelmode.text = "game mode: easy"


func _on_starting_menu_normal() -> void:
	labelmode.text = "game mode: normal"



func _on_starting_menu_hard() -> void:
	labelmode.text = "game mode: hard"
