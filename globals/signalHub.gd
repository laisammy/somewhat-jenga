extends Node

signal on_game_over
signal on_brick_landed(y_position: float)
signal on_brick_dropped(brick_transform: Transform3D)
signal on_score_increased(spawnTime: float)
signal on_new_high_score(newHighScore: int)
signal on_timeLeft_ui(timeLeft: int)

func emit_on_brick_dropped(brick_transform: Transform3D) -> void:
	on_brick_dropped.emit(brick_transform)

func emit_on_game_over() -> void:
	on_game_over.emit()
	
func emit_on_brick_landed(y_position: float) -> void:
	on_brick_landed.emit(y_position)

func emit_on_score_increased(spawnTime: float) -> void:
	on_score_increased.emit(spawnTime)
	
func emit_on_new_high_score(newHighScore: int) -> void:
	#print("emit_on_new_high_score")
	on_new_high_score.emit(newHighScore)
	
func emit_on_timeLeft_ui(timeLeft: float) -> void:
	on_timeLeft_ui.emit(timeLeft)
