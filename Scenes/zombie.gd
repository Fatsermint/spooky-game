extends Node3D
@onready var animations: AnimationPlayer = $zombie/AnimationPlayer2



func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	animations.play("IDLE")
