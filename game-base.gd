extends Control
class_name GameBase

var board_size: int = 10
var board: Array

func _ready() -> void:
	board = []
	board.resize(board_size ** 2)
	board.fill(false)

	board[33] = true
	board[34] = true
	board[35] = true

func _process(_delta: float) -> void:
	var has_changed: bool = false
	var new_board: Array = board

	if has_changed:
		board = new_board
		queue_redraw()
