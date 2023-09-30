extends "res://addons/sound_manager/abstract_audio_player_pool.gd"


func play(resource: AudioStream, pitch: float = 1.0, override_bus: String = "") -> AudioStreamPlayer:
	var player = prepare(resource, override_bus)
	player.pitch_scale = pitch
	player.call_deferred("play")
	return player
