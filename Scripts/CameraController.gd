extends Camera3D
class_name CameraController

@export var mouse_sensitivity := 1.0
@export var y_top := 88.0
@export var y_bottom := -50.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_sensitivity = mouse_sensitivity / 100
	y_top = deg_to_rad(y_top)
	y_bottom = deg_to_rad(y_bottom)

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_x(clamp(-event.relative.y * mouse_sensitivity, y_bottom, y_top))

	if Input.is_action_just_pressed("toggle_mouse"):
		Input.mouse_mode =  Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED