extends Node
@warning_ignore_start("unused_signal")


signal ball_spawn_requested(pos: Vector2)
signal block_hit(block: Node, by: Node)
signal block_destroyed(block: Node)
signal score_changed(value: int)
