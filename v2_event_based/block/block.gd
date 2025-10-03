extends StaticBody2D


@export var hit_points: int = 1

@onready var block_color: MeshInstance2D = $BlockColor

var colors := [
	Color(0.7, 0.364, 0.364, 1.0),
	Color(0.302, 0.443, 0.443, 1.0),
	Color(0.659, 0.635, 0.443, 1.0),
	Color(0.227, 0.635, 0.443, 1.0),
]

func _ready() -> void:
	add_to_group("block")
	block_color.modulate = _random_color()


func take_damage() -> void:
	hit_points -= 1
	# NOTE: Publishing/broadcasting a signal/event
	SignalBus.block_hit.emit(self)
	if hit_points <= 0 and not is_queued_for_deletion():
		SignalBus.block_destroyed.emit(self)
		queue_free()


func _random_color() -> Color:
	# Assign random color
	var c: Color = colors.pick_random()
	c.v = randf_range(c.v-0.1, c.v+0.1)
	return c
