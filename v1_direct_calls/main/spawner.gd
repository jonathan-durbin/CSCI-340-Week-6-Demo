extends Node2D


@export var initial_speed: float = 600.0

@onready var ball_scene: PackedScene = preload("uid://clyuna22c6epv")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_button"):
		# NOTE: Direct call
		_spawn_ball(get_global_mouse_position())


func _spawn_ball(pos: Vector2) -> void:
	var b: RigidBody2D = ball_scene.instantiate()
	b.global_position = pos
	add_child(b, true)
	var dir := Vector2(randf_range(-0.5, 0.5), -1.0).normalized()
	b.apply_impulse(dir * initial_speed)
