extends Control

var canvas = ImageTexture.new()
var width = 100
var height = 100

func _ready() -> void:
	canvas.set_size_override(Vector2(width, height))

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(Vector2(0, 0), Vector2(width, height)), Color.WHITE)
