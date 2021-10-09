extends Node


const AudioPlayerPool = preload("res://addons/sound_manager/audio_player_pool.gd")


onready var audio_player_pool := AudioPlayerPool.new(["Sounds", "sounds", "SFX"])


var bus: String = "Master" setget set_bus


func _ready() -> void:
	add_child(audio_player_pool)


func play(resource: AudioStream, override_bus: String = "") -> void:
	audio_player_pool.play(resource, override_bus)


### SETGET


func set_bus(value: String) -> void:
	audio_player_pool.bus = value
