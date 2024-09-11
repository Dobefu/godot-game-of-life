extends Control

var texture : ImageTexture
var image : Image

var width = 100
var height = 100

var window_size : Vector2i
var window_size_prev : Vector2i

func _ready() -> void:
	image = Image.create_empty(width, height, false, Image.FORMAT_L8)
	texture = ImageTexture.create_from_image(image)


func _process(_delta: float) -> void:
	window_size = get_window().size
	texture.update(image)

	if (window_size != window_size_prev):
		window_size_prev = window_size

func _draw() -> void:
	image.set_pixel(5, 5, Color.WHITE)

	draw_texture_rect(texture, Rect2(Vector2(0, 0), Vector2(500, 500)), false)
