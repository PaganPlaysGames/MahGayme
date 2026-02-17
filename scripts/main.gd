extends Node2D

var defeated_slimes: int = 0

@onready var quest_label: Label = $CanvasLayer/UI/QuestLabel
@onready var counter_label: Label = $CanvasLayer/UI/CounterLabel
@onready var player_hitbox: Area2D = $Player/SwordHitbox

func _ready() -> void:
	player_hitbox.area_entered.connect(_on_sword_hitbox_area_entered)
	_update_ui()

func _on_sword_hitbox_area_entered(area: Area2D) -> void:
	var owner_node := area.owner
	if owner_node and owner_node.has_method("defeat"):
		owner_node.defeat()
		defeated_slimes += 1
		_update_ui()

func _update_ui() -> void:
	counter_label.text = "Slimes defeated: %d / 5" % defeated_slimes
	if defeated_slimes >= 5:
		quest_label.text = "Quest Complete! Return to Henesys."
	else:
		quest_label.text = "Quest: Defeat 5 slimes in the training field."
