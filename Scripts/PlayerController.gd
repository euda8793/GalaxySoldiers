extends CharacterBody3D
class_name PlayerController

@onready var weapon := %FirstPersonWeapon as Weapon
@export var gravity_multiplier := 3.0
@export var speed := 10
@export var acceleration := 8
@export var deceleration := 10
@export_range(0.0, 1.0, 0.05) var air_control := 0.3
@export var jump_height := 25 

@export var mouse_sensitivity := 2.0

var direction : Vector3
var input_axis : Vector2

@onready var gravity: float = (ProjectSettings.get_setting("physics/3d/default_gravity") 
		* gravity_multiplier)

func _ready():
	mouse_sensitivity = mouse_sensitivity / 10.0

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

	if Input.is_action_just_pressed("left_click"):
		weapon.begin_shooting()
	if Input.is_action_just_released("left_click"):
		weapon.stop_shooting()


func _physics_process(delta: float) -> void:
	input_axis = Input.get_vector(&"ui_down", &"ui_up",
			&"ui_left", &"ui_right")

	direction_input()
	
	if is_on_floor():
		if Input.is_action_just_pressed(&"jump"):
			velocity.y = jump_height
	else:
		velocity.y -= gravity * delta
	
	accelerate(delta)
	move_and_slide()

func accelerate(delta: float) -> void:
	var temp_accel: float
	var target: Vector3 = direction * speed
	
	if direction.dot(velocity) > 0:
		temp_accel = acceleration
	else:
		temp_accel = deceleration
	
	if not is_on_floor():
		temp_accel *= air_control
	
	velocity = velocity.lerp(target, temp_accel * delta)
	
func direction_input() -> void:
	var aim : Basis = get_global_transform().basis
	direction = aim.z * -input_axis.x + aim.x * input_axis.y