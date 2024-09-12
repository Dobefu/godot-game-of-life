extends Control

var texture: ImageTexture
var image: Image

var width: int = 10
var height: int = 10

var window_size: Vector2i
var window_size_prev: Vector2i

func _ready() -> void:
	image = Image.create_empty(width, height, false, Image.FORMAT_L8)
	image.fill(Color.WHITE)
	texture = ImageTexture.create_from_image(image)

func _process(_delta: float) -> void:
	window_size = get_window().size
	texture.update(image)
	queue_redraw()

	if (window_size != window_size_prev):
		window_size_prev = window_size
		queue_redraw()

func _draw() -> void:
	image.set_pixel(5, 5, Color.GRAY)
	image.set_pixel(6, 6, Color.GRAY)

	var draw_size: float = min(window_size.x, window_size.y)
	var draw_offset_x: float = float(window_size.x) / 2 - draw_size / 2
	var draw_offset_y: float = float(window_size.y) / 2 - draw_size / 2
	draw_texture_rect(texture, Rect2(Vector2(draw_offset_x, draw_offset_y), Vector2(draw_size, draw_size)), false)
