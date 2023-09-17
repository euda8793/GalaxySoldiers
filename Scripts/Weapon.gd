extends Camera3D
class_name Weapon

@export
var weapon_configuration : WeaponConfiguration

@onready
var sound_player := %AnimationPlayer as AnimationPlayer

@onready
var gun_model := %GunModel as GunModel

@onready
var aim := %Aim as Aim

@export 
var mouse_sensitivity := 2.0

@export 
var y_top := 80.0

@export 
var y_bottom := -60.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_sensitivity = mouse_sensitivity / 1000
	y_top = deg_to_rad(y_top)
	y_bottom = deg_to_rad(y_bottom)

func _input(event : InputEvent) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return;
	
	if event is InputEventMouseMotion:
		var adding_rotation = -event.relative.y * mouse_sensitivity
		rotation.x = clamp(adding_rotation + rotation.x, y_bottom, y_top)


func begin_shooting() -> void:
	sound_player.play("MachineGun-loop")
	gun_model.start_movement()
	aim.start()
	

func stop_shooting() -> void:
	sound_player.stop()
	gun_model.stop_movement()
	aim.stop()
