extends Node


var score: int = 0
@onready var score_label := $UI/ScoreLabel


func _ready() -> void:
	add_to_group("main_controller")
	_update_ui()


# NOTE: This gets called directly
func add_score() -> void:
	score += 10
	_update_ui()


func _update_ui() -> void:
	score_label.text = "Score: %d" % score
