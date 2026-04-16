extends RigidBody3D

class_name Brick

const TABLE_GROUP: String = "table"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_sleeping_state_changed() -> void:
	print("_on_sleeping_state_changed: ", sleeping)
	SignalHub.emit_on_brick_landed(position.y)

func _on_body_entered(body: Node) -> void:
	print("Brick has collided with " + str(body))
	if body.is_in_group(TABLE_GROUP):
		print("Game over")
		SignalHub.emit_on_game_over()
