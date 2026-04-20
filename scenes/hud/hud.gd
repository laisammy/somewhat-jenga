extends Control

@onready var game_over: ColorRect = $gameOver
@onready var scoreLabel: Label = $colorRect/marginContainer/hBoxContainer2/vBoxContainer/score
@onready var high_score: Label = $colorRect/marginContainer/hBoxContainer2/vBoxContainer2/highScore

@onready var bricks_landed: Label = $colorRect/marginContainer/hBoxContainer/vBoxContainer2/bricksLanded
@onready var spawn_timeLabel: Label = $colorRect/marginContainer/hBoxContainer/vBoxContainer/spawnTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_game_over.connect(on_game_over)
	SignalHub.on_brick_landed.connect(on_brick_landed)
	SignalHub.on_score_increased.connect(on_score_increased)
	SignalHub.on_new_high_score.connect(on_new_high_score)
	SignalHub.on_timeLeft_ui.connect(on_timeLeft_ui)
	
	high_score.text = str(GameState.highScore).pad_zeros(3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_game_over() -> void:
	game_over.show()
	
func _unhandled_input(event: InputEvent) -> void:
	if game_over.visible and event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()

func on_brick_landed(y_position: float) -> void:
	bricks_landed.text = str(GameState.bricksLanded).pad_zeros(3)
	
func on_score_increased(spawn_time: float) -> void:
	GameState.score += 1
	#print("Score: ", GameState.score)
	scoreLabel.text = str(GameState.score).pad_zeros(3)
	spawn_timeLabel.text = "%.1f" % spawn_time
	
func on_new_high_score(newHighScore: int) -> void:
	#print("on_new_high_score")
	high_score.text = str(GameState.highScore).pad_zeros(3)
	
func on_timeLeft_ui(timeLeft: float) -> void:
	#print("on_timeLeft_ui: ", timeLeft)
	var msec = fmod(timeLeft, 1) * 10
	var sec = fmod(timeLeft, 60)
	var formatString = "%01d.%01d"
	var actualString = formatString % [sec, msec]
	spawn_timeLabel.text = actualString
