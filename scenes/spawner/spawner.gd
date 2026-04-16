extends Node3D

@onready var pivot: Node3D = $pivot

const moveLimit: float = 2.0

var rotationSpeed: float = 2.0
var moveSpeed: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_brick_landed.connect(on_brick_landed)
	SignalHub.on_game_over.connect(on_game_over)

func handleRotation(delta: float) -> void:
	var rotationInput: float = Input.get_axis(
		"rotateCounterClockwise", "rotateClockwise"
	) # Convert into a single axis value (-1 to 1)
	pivot.rotate_y(rotationInput * delta * rotationSpeed)

func handleTranslation(delta: float) -> void:
	var trZ: float = Input.get_axis("left", "right")
	var trX: float = Input.get_axis("backward", "forward")
	
	var moveDelta: Vector3 = Vector3(trX, 0, trZ) * delta * moveSpeed
	var newPos: Vector3 = pivot.global_position + moveDelta
	
	newPos.x = clampf(newPos.x, -moveLimit, moveLimit) # clampf forces a number to stay within a range
	newPos.z = clampf(newPos.z, -moveLimit, moveLimit)
	
	pivot.global_position = newPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleRotation(delta)
	handleTranslation(delta)
	
func on_brick_landed(y_position: float) -> void:
	print("Spawner: on_brick_landed: ", y_position)
	
func on_game_over() -> void:
	print("Spawner: on_game_over")
