extends MarginContainer

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var node_2d: MarginContainer = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	node_2d.size.y = get_window().size.y
	node_2d.size.x = get_window().size.x
