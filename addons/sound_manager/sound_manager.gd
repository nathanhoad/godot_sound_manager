extends Node


const SoundEffectsPlayer = preload("res://addons/sound_manager/sound_effects.gd")
const MusicPlayer = preload("res://addons/sound_manager/music.gd")


onready var sound_effects: SoundEffectsPlayer = $SoundEffects
onready var ui_sound_effects: SoundEffectsPlayer = $UISoundEffects
onready var music: MusicPlayer = $Music


func set_sound_volume(volume_between_0_and_1) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(sound_effects.bus), linear2db(volume_between_0_and_1))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(ui_sound_effects.bus), linear2db(volume_between_0_and_1))


func play_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return sound_effects.play(resource, override_bus)


func play_ui_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return ui_sound_effects.play(resource, override_bus)


func set_default_sound_bus(bus: String) -> void:
	sound_effects.bus = bus


func set_default_ui_sound_bus(bus: String) -> void:
	ui_sound_effects.bus = bus


func set_music_volume(volume_between_0_and_1: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(music.bus), linear2db(volume_between_0_and_1))


func play_music(resource: AudioStream, crossfade_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	return music.play(resource, 0.0, crossfade_duration, override_bus)


func play_music_at_volume(resource: AudioStream, volume: float = 0.0, crossfade_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	return music.play(resource, volume, crossfade_duration, override_bus)


func get_music_track_history() -> Array:
	return music.track_history


func get_last_played_music_track() -> String:
	return music.track_history[0]


func is_music_playing(resource: AudioStream = null) -> bool:
	return music.is_playing(resource)
	

func is_music_track_playing(resource_path: String) -> bool:
	return music.is_track_playing(resource_path)


func get_currently_playing_music() -> Array:
	return music.get_current()


func get_currently_playing_music_tracks() -> Array:
	return music.get_current_tracks()


func stop_music(fade_out_duration: float = 0) -> void:
	music.stop(fade_out_duration)


func set_default_music_bus(bus: String) -> void:
	music.bus = bus
