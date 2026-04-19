extends Node

@export var brick_scene: PackedScene

@onready var brick_container: Node = $brickContainer

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	GameState.resetGame()
	SignalHub.on_brick_dropped.connect(emit_on_brick_dropped)

func emit_on_brick_dropped(brick_transform: Transform3D) -> void:
	var new_brick: Brick = brick_scene.instantiate()
	new_brick.global_transform = brick_transform
	brick_container.add_child(new_brick)
