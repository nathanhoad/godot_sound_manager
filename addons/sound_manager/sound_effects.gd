extends Node


const AudioPlayerPool = preload("res://addons/sound_manager/audio_player_pool.gd")


onready var audio_player_pool := AudioPlayerPool.new(["Sounds", "sounds", "SFX"])
onready var ui_audio_player_pool := AudioPlayerPool.new(["UI", "Interface", "interface", "Sounds", "sounds", "SFX"])


var bus: String = "Master" setget set_bus
var ui_bus: String = "Master" setget set_ui_bus


func _ready() -> void:
	add_child(audio_player_pool)
	add_child(ui_audio_player_pool)
	
	bus = audio_player_pool.bus
	ui_bus = ui_audio_player_pool.bus


func play(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return audio_player_pool.play(resource, override_bus)


func play_ui(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return ui_audio_player_pool.play(resource, override_bus)


### Setget


func set_bus(value: String) -> void:
	audio_player_pool.bus = value


func set_ui_bus(value: String) -> void:
	ui_audio_player_pool.bus = value
