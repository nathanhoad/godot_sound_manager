extends Node


export var default_busses := []
export var default_pool_size := 8


var available_players: Array = []
var busy_players: Array = []
var bus: String = "Master"


func _ready(possible_busses: Array = default_busses, pool_size: int = default_pool_size) -> void:
	for possible_bus in possible_busses:
		if AudioServer.get_bus_index(possible_bus) > -1:
			bus = possible_bus
			break
	
	for i in pool_size:
		increase_pool()


func prepare(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	var player = get_available_player()
	player.stream = resource
	player.bus = override_bus if override_bus != "" else bus
	player.volume_db = linear2db(1.0)
	player.pitch_scale = 1
	return player


func get_available_player() -> AudioStreamPlayer:
	if available_players.size() == 0:
		increase_pool()
	var player = available_players.pop_front()
	busy_players.append(player)
	return player


func mark_player_as_available(player: AudioStreamPlayer) -> void:
	if busy_players.has(player):
		busy_players.erase(player)
		
	if not available_players.has(player):
		available_players.append(player)


func increase_pool() -> void:
	var player := AudioStreamPlayer.new()
	add_child(player)
	available_players.append(player)
	player.bus = bus
	player.connect("finished", self, "_on_player_finished", [player])
  

### SIGNALS


func _on_player_finished(player: AudioStreamPlayer) -> void:
	mark_player_as_available(player)
