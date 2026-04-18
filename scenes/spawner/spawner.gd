extends Node3D

@onready var pivot: Node3D = $pivot
@onready var timer: Timer = $timer
@onready var brick_mesh: MeshInstance3D = $pivot/brickMesh

const moveLimit: float = 2.0
const pivotLimit: float = 1.7

var rotationSpeed: float = 2.0
var moveSpeed: float = 2.0
var liftSpeed: float = 5.0
var spawnTime: float = 4.0
var startYPos: float = 0.0
var highestYPos: float = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if !timer.is_stopped() and event.is_action_pressed("drop"):
		print("space")
		timer.stop()
		dropBrick()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startYPos = position.y
	SignalHub.on_brick_landed.connect(on_brick_landed)
	SignalHub.on_game_over.connect(on_game_over)
	on_brick_landed(0) # Spawn first brick

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
	if brick_mesh.visible:
		handleRotation(delta)
		handleTranslation(delta)
	position.y = lerp(position.y, startYPos + highestYPos, delta * liftSpeed) # Smoothly lifts the entire spawner upward as the tower grows
	
func randomPlacePivot() -> void:
	pivot.rotation_degrees = Vector3(0, randf_range(0, 360), 0) # Rotates to a random angle
	pivot.position.x = randf_range(-pivotLimit, pivotLimit) # Moves to a random X/Z position
	pivot.position.z = randf_range(-pivotLimit, pivotLimit)
	
func raisePivot(yPos: float) -> void:
	if yPos > highestYPos: # Whenever a brick lands, if its higher than previous bricks, the spawner's target height increases
		highestYPos = yPos
	
func startTimer() -> void:
	timer.wait_time = spawnTime
	timer.start()
	
func showBrick() -> void:
	brick_mesh.show()
	
func dropBrick() -> void:
	SignalHub.emit_on_brick_dropped(brick_mesh.global_transform)
	brick_mesh.hide()
	
func on_brick_landed(yPos: float) -> void:
	raisePivot(yPos) # Raise spawner height
	randomPlacePivot() # Move pivot to a new random location
	showBrick() # Show the next brick
	startTimer() # Start the timer to drop it
	
func on_game_over() -> void:
	print("Spawner: on_game_over")
	
func _on_timer_timeout () -> void:
	dropBrick()
