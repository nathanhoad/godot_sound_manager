extends Node

var available_players: Array = []
var busy_players: Array = []
var bus: String = "Master"


func _init(possible_busses: Array, pool_size: int = 8) -> void:
	for possible_bus in possible_busses:
		if AudioServer.get_bus_index(possible_bus) > -1:
			bus = possible_bus
			break
	
	for i in pool_size:
		increase_pool()


func prepare(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	var player = get_available_player()
	player.stream = resource
	player.volume_db = linear2db(1)
	player.pitch_scale = 1
	player.bus = override_bus if override_bus != "" else bus
	return player
  

func play(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	var player = prepare(resource, override_bus)
	player.play()
	return player


func get_available_player() -> AudioStreamPlayer:
	if available_players.size() == 0:
		increase_pool()
	var player = available_players.pop_front()
	busy_players.append(player)
	return player


func fade_volume(player: AudioStreamPlayer, from_volume: int, to_volume: int, duration: int):
	var tween = Tween.new()
	add_child(tween)
	if from_volume > to_volume:
		# Fade out
		tween.interpolate_property(player, "volume_db", from_volume, to_volume, duration, Tween.TRANS_CIRC, Tween.EASE_IN)
	else:
		# Fade in
		tween.interpolate_property(player, "volume_db", from_volume, to_volume, duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	tween.queue_free()

	if to_volume <= -79:
		player.stop()
  

func increase_pool() -> void:
	var player := AudioStreamPlayer.new()
	add_child(player)
	available_players.append(player)
	player.bus = bus
	player.connect("finished", self, "_on_player_finished", [player])
  

### SIGNALS


func _on_player_finished(player: AudioStreamPlayer) -> void:
  busy_players.erase(player)
  available_players.append(player)
