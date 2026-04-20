extends RayCast3D
@onready var shadow: Sprite3D = $shadow
@onready var ray_cast_3d: RayCast3D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_3d.is_colliding():
		var hitPoint = ray_cast_3d.get_collision_point()
		shadow.global_position = hitPoint
		shadow.show()
