extends Node


const AudioPlayerPool = preload("res://addons/sound_manager/audio_player_pool.gd")


onready var audio_player_pool := AudioPlayerPool.new(["Music", "music"], 2)


var bus: String = "Master" setget set_bus


func _ready() -> void:
	add_child(audio_player_pool)


func play(resource: AudioStream, crossfade_duration = 0, override_bus: String = "") -> void:
	if is_already_playing(resource): return
	
	# Fading out sounds quicker than fading in in
	stop(crossfade_duration * 2)

	var player = audio_player_pool.prepare(resource, override_bus)
	if crossfade_duration > 0:
		audio_player_pool.fade_volume(player, -80, 0, crossfade_duration)

	yield(get_tree(), "idle_frame")
	player.play()


func stop(fade_out_duration: int = 0) -> void:
	for player in audio_player_pool.busy_players:
		if fade_out_duration <= 0:
			player.stop()
		else:
			audio_player_pool.fade_volume(player, player.volume_db, -80, fade_out_duration)
	yield(get_tree(), "idle_frame")


func is_already_playing(resource: AudioStream) -> bool:
	for player in audio_player_pool.busy_players:
		if player.stream.resource_path == resource.resource_path:
			return true
	return false


### SETGET


func set_bus(value: String) -> void:
	audio_player_pool.bus = value
