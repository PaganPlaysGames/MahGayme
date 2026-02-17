extends CharacterBody2D

@export var patrol_distance: float = 120.0
@export var speed: float = 65.0
@export var gravity: float = 1200.0

var _origin_x: float
var _direction: float = 1.0
var _is_defeated: bool = false

@onready var body: Polygon2D = $Body

func _ready() -> void:
	_origin_x = global_position.x

func _physics_process(delta: float) -> void:
	if _is_defeated:
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = _direction * speed
	if abs(global_position.x - _origin_x) > patrol_distance:
		_direction *= -1.0
		body.scale.x = _direction

	move_and_slide()

func defeat() -> void:
	if _is_defeated:
		return
	_is_defeated = true
	queue_free()
