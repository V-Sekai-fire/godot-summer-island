extends CharacterBody3D


@export var dir: = Vector3(0.0, 0.0, 1.0):
	set=_changed_dir
@export_range(0.001, 10.0) var speed: = 1.0
@export_range(0.001, 20.0) var length: = 1.0
@export_range(0.001, 10.0) var radius: = 0.5:
	set=_changed_radius

@export var blow: = false:
	set=_start_blow

var orig_pos: = Vector3.ZERO

func _changed_dir(new_dir) -> void:
	if new_dir == dir:
		return
	
	dir = new_dir.normalized()

func _changed_radius(new_radius) -> void:
	if new_radius == radius:
		return
	
	radius = new_radius
	if $CollisionShape.shape != null:
		$CollisionShape.shape.radius = radius

func _start_blow(new_state) -> void:
	if new_state == blow:
		return
	
	blow = new_state
	if blow:
		set_physics_process(true)
		$CollisionShape.disabled = false
	else:
		set_physics_process(false)
		$CollisionShape.disabled = true

func _ready() -> void:
	orig_pos = position
	var c = SphereShape3D.new()
	$CollisionShape.shape = c
	$CollisionShape.shape.radius = radius

func _physics_process(delta: float) -> void:
	position += dir * speed * delta
	
	if orig_pos.distance_to(position) >= length:
		position = orig_pos
