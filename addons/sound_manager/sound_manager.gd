extends Node


const SoundEffects = preload("res://addons/sound_manager/sound_effects.gd")
const Music = preload("res://addons/sound_manager/music.gd")


onready var sound_effects: SoundEffects = SoundEffects.new()
onready var music: Music = Music.new()


func _ready() -> void:
	add_child(sound_effects)
	add_child(music)


func play_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return sound_effects.play(resource, override_bus)


func play_ui_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return sound_effects.play_ui(resource, override_bus)


func set_default_sound_bus(bus: String) -> void:
	sound_effects.bus = bus


func set_default_ui_sound_bus(bus: String) -> void:
	sound_effects.ui_bus = bus


func play_music(resource: AudioStream, crossfade_duration: int = 0, override_bus: String = "") -> AudioStreamPlayer:
	return music.play(resource, crossfade_duration, override_bus)


func stop_music(fade_out_duration: int = 0) -> void:
	music.stop(fade_out_duration)


func set_default_music_bus(bus: String) -> void:
	music.bus = bus
