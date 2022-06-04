extends "res://addons/sound_manager/abstract_audio_player_pool.gd"


var tweens: Dictionary = {}
var track_history: Array = []


func play(resource: AudioStream, volume: float = 0.0, crossfade_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	stop(crossfade_duration * 2)
	
	var player = _get_player_with_music(resource)
	
	# If the player already exists then just make sure the volume is right (it might have just been fading in or out)
	if player != null:
		fade_volume(player, player.volume_db, volume, crossfade_duration)
		return player
	
	# Otherwise we need to prep another player and handle its introduction
	player = prepare(resource, override_bus)
	fade_volume(player, -80.0, volume, crossfade_duration)
	
	# Remember this track name
	track_history.insert(0, resource.resource_path)
	if track_history.size() > 50:
		track_history.remove(50)

	player.call_deferred("play")
	return player


func is_playing(resource: AudioStream) -> bool:
	if resource != null:
		return _get_player_with_music(resource) != null
	else:
		return busy_players.size() > 0


func stop(fade_out_duration: float = 0.0) -> void:
	for player in busy_players:
		if fade_out_duration <= 0.0:
			fade_out_duration = 0.01
		fade_volume(player, player.volume_db, -80, fade_out_duration)


func is_track_playing(resource_path: String) -> bool:
	for player in busy_players:
		if player.stream.resource_path == resource_path:
			return true
	return false


func get_currently_playing() -> Array:
	var tracks = []
	for player in busy_players:
		tracks.append(player.stream)
	return tracks


func get_currently_playing_tracks() -> Array:
	var tracks = []
	for player in busy_players:
		tracks.append(player.stream.resource_path)
	return tracks


func fade_volume(player: AudioStreamPlayer, from_volume: float, to_volume: float, duration: float) -> AudioStreamPlayer:
	# Remove any tweens that might already be on this player
	_remove_tween(player)
	
	# Start a new tween
	var tween = Tween.new()
	add_child(tween)
	
	player.volume_db = from_volume
	if from_volume > to_volume:
		# Fade out
		tween.interpolate_property(player, "volume_db", from_volume, to_volume, duration, Tween.TRANS_CIRC, Tween.EASE_IN)
	else:
		# Fade in
		tween.interpolate_property(player, "volume_db", from_volume, to_volume, duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	
	tweens[player] = tween
	tween.connect("tween_all_completed", self, "_on_fade_completed", [player, tween, from_volume, to_volume, duration])
	tween.start()

	return player


### Helpers


func _get_player_with_music(resource: AudioStream) -> AudioStreamPlayer:
	for player in busy_players:
		if player.stream.resource_path == resource.resource_path:
			return player
	return null


func _remove_tween(player: AudioStreamPlayer) -> void:
	if tweens.has(player):
		var fade = tweens.get(player)
		fade.stop_all()
		fade.queue_free()
		tweens.erase(player)


### Signals


func _on_fade_completed(player: AudioStreamPlayer, tween: Tween, from_volume: float, to_volume: float, duration: float):
	_remove_tween(player)
	
	# If we just faded out then our player is now available
	if to_volume <= -79.0:
		player.stop()
		mark_player_as_available(player)
