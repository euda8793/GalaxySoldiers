@tool

extends Node3D
class_name Weapon

@export
var weapon_configuration : WeaponConfiguration

@onready
var sound_player := $AnimationPlayer as AnimationPlayer

@onready
var reticle := $ReticleOverlay as Reticle

var rotate_tween : Tween
var muzzle_tween : Tween

var recoil_up : float
var recoil_down : float

func _ready():
	recoil_up = weapon_configuration.fire_rate / 30.0
	recoil_down = weapon_configuration.fire_rate / 20.0

func begin_shooting() -> void:
	rotate_tween = get_tree().create_tween()
	muzzle_tween = get_tree().create_tween()
	sound_player.play("MachineGun-loop")
	reticle.start()

	rotate_tween.set_trans(Tween.TRANS_BOUNCE)
	muzzle_tween.set_trans(Tween.TRANS_BOUNCE)

	rotate_tween.set_loops()
	rotate_tween.tween_property($Handle, "rotation_degrees", Vector3(-weapon_configuration.recoil_magnitude, 0.0, 0.0), recoil_up)
	rotate_tween.tween_property($Handle, "rotation_degrees", Vector3.ZERO, recoil_down)

	muzzle_tween.set_loops()
	muzzle_tween.tween_property($Handle/Mesh/MuzzleFlash, "visible", true, 0.01)
	muzzle_tween.tween_property($Handle/Mesh/MuzzleFlash, "scale", Vector3.ONE / 2.0, recoil_up)
	muzzle_tween.tween_property($Handle/Mesh/MuzzleFlash, "scale", Vector3.ZERO, recoil_down)
	muzzle_tween.tween_property($Handle/Mesh/MuzzleFlash, "visible", false, 0.01)

func stop_shooting() -> void:
	rotate_tween.kill()
	muzzle_tween.kill()

	sound_player.stop()
	reticle.stop()
	rotate_tween = get_tree().create_tween()
	muzzle_tween = get_tree().create_tween()

	rotate_tween.tween_property($Handle, "rotation_degrees", Vector3.ZERO, recoil_down)
	rotate_tween.tween_callback(func (): rotate_tween.kill())

	muzzle_tween.tween_property($Handle/Mesh/MuzzleFlash, "scale", Vector3.ZERO, recoil_down)
	muzzle_tween.tween_property($Handle/Mesh/MuzzleFlash, "visible", false, 0.01)
	muzzle_tween.tween_callback(func (): muzzle_tween.kill())
