extends "res://game-base.gd"
class_name Game

var texture: ImageTexture
var image: Image

var window_size: Vector2i
var window_size_prev: Vector2i

var gui_height: float = 100

func _ready() -> void:
	super()

	image = Image.create_empty(board_size, board_size, false, Image.FORMAT_L8)
	_draw()
	texture = ImageTexture.create_from_image(image)

func _input(event):
	if (state != State.PAUSED):
		return

	if (!event is InputEventMouseButton || !event.pressed):
		return

	if (event.button_index != MOUSE_BUTTON_LEFT):
		return

	var draw_size: float = min(window_size.x, window_size.y - gui_height)
	var draw_offset_x: float = float(window_size.x) / 2 - draw_size / 2
	var draw_offset_y: float = (float(window_size.y) / 2 - draw_size / 2) - (gui_height / 2)
	var cell_size: float = draw_size / board_size

	var cell_x: int = floor((event.position.x - draw_offset_x) / cell_size)
	var cell_y: int = floor((event.position.y - draw_offset_y) / cell_size)

	if (cell_x < 0 || cell_x > board_size - 1 || cell_y < 0 || cell_y > board_size - 1):
		return

	var index: int = (((cell_x % board_size) + 1) + ((cell_y % board_size) * board_size)) - 1
	board[index] = !board[index]
	_draw()
	texture.update(image)
	queue_redraw()

func _process(_delta: float) -> void:
	super(_delta)

	window_size = get_window().size

	if (has_changed):
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

	var draw_size: float = min(window_size.x, window_size.y - gui_height)
	var draw_offset_x: float = float(window_size.x) / 2 - draw_size / 2
	var draw_offset_y: float = (float(window_size.y) / 2 - draw_size / 2) - (gui_height / 2)
	draw_texture_rect(texture, Rect2(Vector2(draw_offset_x, draw_offset_y), Vector2(draw_size, draw_size)), false)
