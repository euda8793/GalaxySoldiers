extends Node3D
class_name GunModel

@export
var weapon_configuration : WeaponConfiguration

var recoil_up : float
var recoil_down : float
var rotate_tween : Tween
var muzzle_tween : Tween

func _ready() -> void:
	recoil_up = weapon_configuration.fire_rate / 30.0
	recoil_down = weapon_configuration.fire_rate / 20.0

func start_movement() -> void:
	if (rotate_tween != null and rotate_tween.is_running()): return
	
	rotate_tween = get_tree().create_tween()
	muzzle_tween = get_tree().create_tween()

	rotate_tween.set_loops()
	muzzle_tween.set_loops()
	
	rotate_tween.set_trans(Tween.TRANS_BOUNCE)
	muzzle_tween.set_trans(Tween.TRANS_BOUNCE)

	rotate_tween.tween_property(self, "rotation_degrees", Vector3(-weapon_configuration.recoil_magnitude, 0.0, 0.0), recoil_up)
	rotate_tween.tween_property(self, "rotation_degrees", Vector3.ZERO, recoil_down)

	muzzle_tween.tween_property(%"MuzzleFlash", "visible", true, 0.01)
	muzzle_tween.tween_property(%"MuzzleFlash", "scale", Vector3.ONE / 2.0, recoil_up)
	muzzle_tween.tween_property(%"MuzzleFlash", "scale", Vector3.ZERO, recoil_down)
	muzzle_tween.tween_property(%"MuzzleFlash", "visible", false, 0.01)

func stop_movement() -> void:
	rotate_tween.kill()
	muzzle_tween.kill()
	rotate_tween = get_tree().create_tween()
	muzzle_tween = get_tree().create_tween()
	
	rotate_tween.tween_property(self, "rotation_degrees", Vector3.ZERO, recoil_down)
	rotate_tween.tween_callback(func (): 
		rotate_tween.kill())

	muzzle_tween.tween_property(%"MuzzleFlash", "scale", Vector3.ZERO, recoil_down)
	muzzle_tween.tween_property(%"MuzzleFlash", "visible", false, 0.01)
	muzzle_tween.tween_callback(func (): 
		muzzle_tween.kill())
