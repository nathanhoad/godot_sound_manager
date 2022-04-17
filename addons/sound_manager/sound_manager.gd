extends Node


const SoundEffectsPlayer = preload("res://addons/sound_manager/sound_effects.gd")
const MusicPlayer = preload("res://addons/sound_manager/music.gd")


# moved to export vars in abstract_audio_player_pool.gd
# default values assigned in the scene
# onready var sound_effects: SoundEffectsPlayer = SoundEffectsPlayer.new(["Sounds", "sounds", "SFX"])
# onready var ui_sound_effects: SoundEffectsPlayer = SoundEffectsPlayer.new(["UI", "Interface", "interface", "Sounds", "sounds", "SFX"])
# onready var music: MusicPlayer = MusicPlayer.new()


onready var sound_effects: SoundEffectsPlayer = $sound_effects
onready var ui_sound_effects: SoundEffectsPlayer = $ui_sound_effects
onready var music: MusicPlayer = $music


func play_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return sound_effects.play(resource, override_bus)


func play_ui_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return ui_sound_effects.play(resource, override_bus)


func set_default_sound_bus(bus: String) -> void:
	sound_effects.bus = bus


func set_default_ui_sound_bus(bus: String) -> void:
	ui_sound_effects.bus = bus


func play_music(resource: AudioStream, volume: float = 0.0, crossfade_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	return music.play(resource, volume, crossfade_duration, override_bus)


func is_music_playing(resource: AudioStream = null) -> bool:
	return music.is_playing(resource)


# this is not very good
func get_current_music():
	if music.busy_players:
		return music.busy_players[0].stream.resource_path
	else:
		return null


func stop_music(fade_out_duration: float = 0) -> void:
	music.stop(fade_out_duration)


func set_default_music_bus(bus: String) -> void:
	music.bus = bus
