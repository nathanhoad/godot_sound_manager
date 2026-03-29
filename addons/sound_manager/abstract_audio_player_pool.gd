extends Node


@export var default_busses: PackedStringArray = []
@export var default_pool_size: int = 8


var available_players: Array[AudioStreamPlayer] = []
var busy_players: Array[AudioStreamPlayer] = []
var bus: String = "Master"

var _tweens: Dictionary[AudioStreamPlayer, Tween] = {}


func _init(possible_busses: PackedStringArray = default_busses, pool_size: int = default_pool_size) -> void:
	bus = get_possible_bus(possible_busses)

	for i: int in pool_size:
		increase_pool()

func get_possible_bus(possible_busses: PackedStringArray) -> String:
	for possible_bus: String in possible_busses:
		var cases: PackedStringArray = [
			possible_bus,
			possible_bus.to_lower(),
			possible_bus.to_camel_case(),
			possible_bus.to_pascal_case(),
			possible_bus.to_snake_case()
		]
		for case: String in cases:
			if AudioServer.get_bus_index(case) > -1:
				return case
	return "Master"


func prepare(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	var player: AudioStreamPlayer

	if resource is AudioStreamRandomizer:
		player = get_player_with_resource(resource)

	if player == null:
		player = get_available_player()

	player.stream = resource
	player.bus = override_bus if override_bus != "" else bus
	player.volume_db = linear_to_db(1.0)
	player.pitch_scale = 1
	return player


func get_available_player() -> AudioStreamPlayer:
	if available_players.size() == 0:
		increase_pool()
	var player: AudioStreamPlayer = available_players.pop_front()
	busy_players.append(player)
	return player


func get_player_with_resource(resource: AudioStream) -> AudioStreamPlayer:
	for player: AudioStreamPlayer in busy_players + available_players:
		if player.stream == resource:
			return player
	return null


func get_busy_player_with_resource(resource: AudioStream) -> AudioStreamPlayer:
	for player: AudioStreamPlayer in busy_players:
		if player.stream.resource_path == resource.resource_path:
			return player
	return null


func mark_player_as_available(player: AudioStreamPlayer) -> void:
	if busy_players.has(player):
		busy_players.erase(player)

	if available_players.size() >= default_pool_size:
		available_players.erase(player)
		player.queue_free()
	elif not available_players.has(player):
		available_players.append(player)


func increase_pool() -> void:
	# See if we can reclaim a rogue busy player
	for player: AudioStreamPlayer in busy_players:
		if not player.playing:
			mark_player_as_available(player)
			return

	# Otherwise, add a new player
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(player)
	available_players.append(player)
	player.bus = bus
	player.finished.connect(_on_player_finished.bind(player))


func fade_volume(player: AudioStreamPlayer, from_volume: float, to_volume: float, duration: float) -> AudioStreamPlayer:
	# Remove any tweens that might already be on this player
	_remove_tween(player)

	# Start a new tween
	var tween: Tween = get_tree().create_tween().bind_node(self)

	player.volume_db = from_volume
	if from_volume > to_volume:
		# Fade out
		tween.tween_property(player, "volume_db", to_volume, duration).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	else:
		# Fade in
		tween.tween_property(player, "volume_db", to_volume, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	_tweens[player] = tween
	tween.finished.connect(_on_fade_completed.bind(player, tween, from_volume, to_volume, duration))

	return player


#region Helpers


func _remove_tween(player: AudioStreamPlayer) -> void:
	if _tweens.has(player):
		var fade: Tween = _tweens.get(player)
		fade.kill()
		_tweens.erase(player)


#endregion

#region Signals


func _on_player_finished(player: AudioStreamPlayer) -> void:
	mark_player_as_available(player)


func _on_fade_completed(player: AudioStreamPlayer, _tween: Tween, _from_volume: float, to_volume: float, _duration: float) -> void:
	_remove_tween(player)

	# If we just faded out then our player is now available
	if to_volume <= -79.0:
		player.stop()
		mark_player_as_available(player)


#endregion
