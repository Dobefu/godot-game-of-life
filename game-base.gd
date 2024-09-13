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

func _ready() -> void:
	board = []
	board.resize(board_size ** 2)
	board.fill(false)

	board[33] = true
	board[34] = true
	board[35] = true

	# TODO Replace once a pause button has been implemented.
	state = State.PLAYING

func _process(_delta: float) -> void:
	tick_delta += _delta

	if (tick_delta < 1):
		return

	tick_delta = tick_delta - 1

	var has_changed: bool = false
	var new_board: Array = board.duplicate()

	if state == State.PLAYING:
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
		queue_redraw()
