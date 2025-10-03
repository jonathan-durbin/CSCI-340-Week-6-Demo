extends Node


var score: int = 0
@onready var score_label := $UI/ScoreLabel


func _ready() -> void:
	# NOTE: Subscribing to signal/event
	SignalBus.block_destroyed.connect(_on_block_destroyed)
	_update_ui()


func _on_block_destroyed(_block: Node) -> void:
	score += 10
	_update_ui()


func _update_ui() -> void:
	score_label.text = "Score: %d" % score
