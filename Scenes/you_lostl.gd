extends Control


@onready var tryAgain: Label = $TextureRect2/Label
@onready var backToMainMenu: Label = $TextureRect3/Label
signal TryAgain
signal Mainmenu
# try again
func _on_button_pressed() -> void:
	TryAgain.emit()
	


func _on_mainMenu_button_pressed() -> void:
	Mainmenu.emit()
