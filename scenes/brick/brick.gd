extends RigidBody3D

class_name Brick

const TABLE_GROUP: String = "table"

@onready var sound_effect: AudioStreamPlayer3D = $soundEffect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_sleeping_state_changed() -> void:
	if sleeping:
		if !GameState.gameOver: # Check if game is over
			GameState.bricksLanded += 1
			SignalHub.emit_on_brick_landed(position.y)
		if sleeping_state_changed.is_connected(_on_sleeping_state_changed):
			sleeping_state_changed.disconnect(_on_sleeping_state_changed)

func _on_body_entered(body: Node) -> void:
	sound_effect.play()
	if body.is_in_group(TABLE_GROUP) and !GameState.gameOver:
		GameState.gameOver = true
		SignalHub.emit_on_game_over()
