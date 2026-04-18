extends Control

@onready var game_over: ColorRect = $gameOver
@onready var bricks_landed: Label = $colorRect/marginContainer/bricksLanded

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_game_over.connect(on_game_over)
	SignalHub.on_brick_landed.connect(on_brick_landed)
	game_over.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_game_over() -> void:
	game_over.show()
	
func _unhandled_input(event: InputEvent) -> void:
	if game_over.visible and event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()

func on_brick_landed(y_position: float) -> void:
	score += 1
	bricks_landed.text = str(score).pad_zeros(3)
