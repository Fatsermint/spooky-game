extends Control

signal play
signal easy
signal normal
signal hard
@onready var Turotail: TextureRect = $TextureRect2
@onready var PlayRect: TextureRect = $TextureRect3
@onready var Header: TextureRect = $TextureRect4
@onready var CURSOR: TextureRect = $"../TextureRect"
@onready var keys: TextureRect = $"../Keys"
@onready var keys_count: Label = $"../KeysCount"
@onready var mahalaukku: TextureRect = $TextureRect


func _ready() -> void:
	Turotail.visible = true
	PlayRect.visible = true
	Header.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_tutibutton_pressed() -> void:
	print("tutorail")


func _on_play_button_pressed() -> void:
	print("PLAY!")

	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mahalaukku.visible = true

func _on_button_pressed() -> void:
	easy.emit()
	mahalaukku.visible = false
	play.emit()
	CURSOR.visible = true
	keys.visible = true
	keys_count.visible = true
	Turotail.visible = false
	PlayRect.visible = false
	Header.visible = false
func _on_normal_button_pressed() -> void:
	normal.emit()
	mahalaukku.visible = false
	play.emit()
	CURSOR.visible = true
	keys.visible = true
	keys_count.visible = true
	Turotail.visible = false
	PlayRect.visible = false
	Header.visible = false
func _on_hard_button_pressed() -> void:
	hard.emit()
	mahalaukku.visible = false
	play.emit()
	CURSOR.visible = true
	keys.visible = true
	keys_count.visible = true
	Turotail.visible = false
	PlayRect.visible = false
	Header.visible = false
