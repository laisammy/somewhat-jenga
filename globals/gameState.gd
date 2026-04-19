extends Node

const PATH: String = "user://userData.dat"

var gameOver: bool = false
var score: int = 0:
	get: return score
	set(value):
		score = value
		if value > highScore:
			highScore = value
			saveHighScore()
			print("High score saved")
			SignalHub.emit_on_new_high_score(highScore)
		
var highScore: int = 0
var bricksLanded: int = 0

func resetGame() -> void:
	gameOver = false
	score = 0
	bricksLanded = 0

func saveHighScore() -> void:
	var file: FileAccess = FileAccess.open(PATH, FileAccess.WRITE)
	if file:
		file.store_32(highScore)
		file.close()
		
func loadHighScore() -> void:
	var file: FileAccess = FileAccess.open(PATH, FileAccess.READ)
	if file:
		highScore = file.get_32()
		file.close()
		
		
