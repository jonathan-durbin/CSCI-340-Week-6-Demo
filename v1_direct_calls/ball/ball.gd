extends RigidBody2D


@onready var ball_color: MeshInstance2D = $BallColor

var colors := [
	Color(0.72, 0.295, 0.281, 1.0),
	Color(0.297, 0.598, 0.69, 1.0),
	Color(0.297, 0.69, 0.506, 1.0),
]

func _ready() -> void:
	add_to_group("ball")
	body_entered.connect(_on_block_hit)
	ball_color.modulate = _random_color()


func _on_block_hit(other: Node) -> void:
	if not other.is_in_group("block"):
		return
	other.take_damage()
	var dir := Vector2(randf_range(-0.3, 0.3), 0.0).normalized()
	apply_impulse(dir * 100)


func _random_color() -> Color:
	# Assign random color
	var c: Color = colors.pick_random()
	c.v = randf_range(c.v-0.1, c.v+0.1)
	return c
