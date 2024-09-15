extends Control
class_name GameBase

enum State {
	PLAYING,
	PAUSED,
}

var board_size: int = 10
var board: Array

var state: State
var tick_delta: float = 0
var max_delay: float = 1
var has_changed: bool = false

func _ready() -> void:
	board = []
	board.resize(board_size ** 2)
	board.fill(false)

	board[33] = true
	board[34] = true
	board[35] = true

	state = State.PAUSED

func _on_check_button_toggled(is_checked: bool) -> void:
	if (is_checked):
		state = State.PLAYING
		return

	state = State.PAUSED

func _on_speed_slider_value_changed(value):
	max_delay = 1 - value

func _process(_delta: float) -> void:
	tick_delta += _delta

	if (max_delay > 0 && tick_delta < max_delay):
		return

	tick_delta = tick_delta - max_delay

	if (max_delay > _delta):
		tick_delta = 0

	has_changed = false
	var new_board: Array = board.duplicate()

	if (state == State.PLAYING):
		for i in range(0, board_size ** 2):
			var live_neighbours: int = 0
			var coords_to_check: Array = [
				i - board_size - 1,
				i - board_size,
				i - board_size + 1,
				i - 1,
				i + 1,
				i + board_size - 1,
				i + board_size,
				i + board_size + 1,
			]

			for j in coords_to_check:
				if j >= 0 && j < board_size ** 2 && board[j] == true:
					live_neighbours += 1

			if live_neighbours < 2:
				if new_board[i] == true:
					has_changed = true
				new_board[i] = false

			if live_neighbours > 3:
				if new_board[i] == true:
					has_changed = true
				new_board[i] = false

			if live_neighbours == 3:
				if new_board[i] == false:
					has_changed = true
				new_board[i] = true

	if has_changed:
		board = new_board
