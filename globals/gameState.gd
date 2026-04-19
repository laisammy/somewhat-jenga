extends Node

var gameOver: bool = false
var score: int = 0
var bricksLanded: int = 0

func resetGame() -> void:
	gameOver = false
	score = 0
	bricksLanded = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
