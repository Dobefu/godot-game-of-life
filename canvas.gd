extends Control

var texture : ImageTexture
var image : Image

var width = 100
var height = 100

var window_size : Vector2i
var window_size_prev : Vector2i

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

func _draw() -> void:
	image.set_pixel(5, 5, Color.GRAY)
	image.set_pixel(6, 6, Color.GRAY)

	var draw_size = min(window_size.x, window_size.y)
	draw_texture_rect(texture, Rect2(Vector2(window_size.x / 2 - draw_size / 2, window_size.y / 2 - draw_size / 2), Vector2i(draw_size, draw_size)), false)
