# v2_event/scripts/SoundSystem.gd
extends Node
## Plays SFX on events with zero coupling to producers.

@export var destroy_sounds: Array[AudioStream]        # drag in a WAV/OGG in the Inspector
@export var volume_db: float = 0.0            # tweak loudness
@export var max_simultaneous: int = 16        # simple guardrail

var _active_players: Array[AudioStreamPlayer2D] = []


func _ready() -> void:
	SignalBus.block_destroyed.connect(_on_block_destroyed)


func _on_block_destroyed(block: Node) -> void:
	if destroy_sounds.size() == 0:
		return
	if _active_players.size() >= max_simultaneous:
		# Drop the oldest to keep it simple
		var oldest: AudioStreamPlayer2D = _active_players.pop_front()
		if oldest:
			oldest.queue_free()

	var p := AudioStreamPlayer2D.new()
	p.stream = destroy_sounds.pick_random()
	p.volume_db = volume_db
	# Try to play at the destroyed block's location; fall back to (0,0)
	if block is Node2D:
		p.global_position = block.global_position
	add_child(p)  # parented here so it persists after block frees

	_active_players.append(p)
	p.play()

	# Clean up when finished
	p.finished.connect(_on_player_finished.bind(p))


func _on_player_finished(p: AudioStreamPlayer2D) -> void:
	_active_players.erase(p)
	if is_instance_valid(p):
		p.queue_free()
