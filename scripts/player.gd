extends CharacterBody2D

@export var move_speed: float = 250.0
@export var jump_velocity: float = -420.0
@export var gravity: float = 1200.0
@export var attack_duration: float = 0.18

var _attack_timer: float = 0.0

@onready var sprite: Polygon2D = $Body
@onready var sword_hitbox: Area2D = $SwordHitbox
@onready var status_label: Label = $StatusLabel

func _ready() -> void:
	sword_hitbox.monitoring = false
	status_label.text = ""

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var input_axis := Input.get_axis("ui_left", "ui_right")
	velocity.x = input_axis * move_speed

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_just_pressed("ui_accept"):
		_start_attack()

	if _attack_timer > 0.0:
		_attack_timer -= delta
		if _attack_timer <= 0.0:
			sword_hitbox.monitoring = false
			status_label.text = ""

	if input_axis != 0.0:
		sprite.scale.x = sign(input_axis)
		sword_hitbox.position.x = 26.0 * sprite.scale.x

	move_and_slide()

func _start_attack() -> void:
	_attack_timer = attack_duration
	sword_hitbox.monitoring = true
	status_label.text = "Slash!"
