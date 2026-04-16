extends Node

signal on_game_over
signal on_brick_landed(y_position: float)

func emit_on_game_over() -> void:
	on_game_over.emit()
	
func emit_on_brick_landed(y_position: float) -> void:
	on_brick_landed.emit(y_position)
