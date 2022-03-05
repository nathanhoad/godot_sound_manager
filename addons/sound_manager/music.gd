extends Node


const AudioPlayerPool = preload("res://addons/sound_manager/audio_player_pool.gd")


onready var audio_player_pool := AudioPlayerPool.new(["Music", "music"], 2)


var bus: String = "Master" setget set_bus


func _ready() -> void:
	add_child(audio_player_pool)


func play(resource: AudioStream, crossfade_duration = 0, override_bus: String = "") -> AudioStreamPlayer:
	var player = get_player_with_music(resource)
	
	if player != null: return player
	
	# Fading out sounds is quicker than fading in
	stop(crossfade_duration * 2)

	player = audio_player_pool.prepare(resource, override_bus)
	if crossfade_duration > 0:
		audio_player_pool.fade_volume(player, -80, 0, crossfade_duration)

	player.call_deferred("play")
	return player


func stop(fade_out_duration: int = 0) -> void:
	for player in audio_player_pool.busy_players:
		if fade_out_duration <= 0:
			player.stop()
		else:
			audio_player_pool.fade_volume(player, player.volume_db, -80, fade_out_duration)


func get_player_with_music(resource: AudioStream) -> AudioStreamPlayer:
	for player in audio_player_pool.busy_players:
		if player.stream.resource_path == resource.resource_path:
			return player
	return null


### Setget


func set_bus(value: String) -> void:
	audio_player_pool.bus = value
