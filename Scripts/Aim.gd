extends Node3D
class_name Aim

@export
var aim_config : AimConfiguration

@onready
var reticle_overlay := $ReticleOverlay as Reticle

@onready
var hit_picker := $HitPicker as RayCast3D

@export
var camera : Camera3D

func start() -> void:
	reticle_overlay.start()

func stop() -> void:
	reticle_overlay.stop()

func pick_spot_in_radius(radius : float) -> Vector2:
	return Vector2()

func notify_hit() -> void:
	hit_picker.force_raycast_update()
	if (hit_picker.is_colliding()):
		var collider := hit_picker.get_collider()
		print(collider)

