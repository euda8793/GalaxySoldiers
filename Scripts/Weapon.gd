extends Node3D
class_name Weapon

@export
var weapon_configuration : WeaponConfiguration

@onready
var animTree : AnimationTree

func fire() -> void:
	animTree["parameters/OneShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	
func stop_firing() -> void:
	animTree["parameters/OneShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT

func recoil() -> void:
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($Handle, "rotation_degrees", Vector3(weapon_configuration.recoil_magnitude, 0.0, 0.0), weapon_configuration.recoil_up)
	tween.tween_property($Handle, "rotation_degrees", Vector3.ZERO, weapon_configuration.recoil_down)
	tween.tween_callback(func (): tween.kill());
	var other = get_tree().create_tween()
	other.set_trans(Tween.TRANS_BOUNCE)
	other.tween_property($Handle/Mesh/MuzzleFlash, "visible", true, 0.01)
	other.tween_property($Handle/Mesh/MuzzleFlash, "scale", Vector3.ONE / 2.0, weapon_configuration.recoil_up)
	other.tween_property($Handle/Mesh/MuzzleFlash, "scale", Vector3.ZERO, weapon_configuration.recoil_down)
	other.tween_property($Handle/Mesh/MuzzleFlash, "visible", false, 0.01)
	other.tween_callback(func (): other.kill());


func _input(_event):
	if Input.is_action_pressed("ui_accept"):
		recoil()