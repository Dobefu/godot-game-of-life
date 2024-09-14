extends "res://game-base.gd"
class_name Game

var texture: ImageTexture
var image: Image

var window_size: Vector2i
var window_size_prev: Vector2i

func _ready() -> void:
	super()

	image = Image.create_empty(board_size, board_size, false, Image.FORMAT_L8)
	image.fill(Color.WHITE)
	texture = ImageTexture.create_from_image(image)

func _process(_delta: float) -> void:
	super(_delta)

	window_size = get_window().size
	texture.update(image)
	queue_redraw()

	if (window_size != window_size_prev):
		window_size_prev = window_size
		queue_redraw()

func _draw() -> void:
	image.fill(Color.WHITE)

	for i in range(0, board_size ** 2):
		if board[i]:
			image.set_pixel((i % board_size), floori(float(i) / board_size), Color.BLACK)

	var draw_size: float = min(window_size.x, window_size.y - 100)
	var draw_offset_x: float = float(window_size.x) / 2 - draw_size / 2
	var draw_offset_y: float = (float(window_size.y) / 2 - draw_size / 2) - 50
	draw_texture_rect(texture, Rect2(Vector2(draw_offset_x, draw_offset_y), Vector2(draw_size, draw_size)), false)
