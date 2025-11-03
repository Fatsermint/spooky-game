extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@onready var node_2d: TextureRect = self
@onready var label: Label = $Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	node_2d.size.y = get_window().size.y
	node_2d.size.x = get_window().size.x
