extends Node


const SoundEffectsPlayer = preload("./sound_effects.gd")
const AmbientSoundsPlayer = preload("./ambient_sounds.gd")
const MusicPlayer = preload("./music.gd")

var sound_effects: SoundEffectsPlayer = SoundEffectsPlayer.new(["Sounds", "SFX"], 8)
var ui_sound_effects: SoundEffectsPlayer = SoundEffectsPlayer.new(["UI", "Interface", "Sounds", "SFX"], 8)
var ambient_sounds: AmbientSoundsPlayer = AmbientSoundsPlayer.new(["Sounds", "SFX"], 1)
var music: MusicPlayer = MusicPlayer.new(["Music"], 2)

var sound_process_mode: ProcessMode:
	set(value):
		sound_effects.process_mode = value
	get:
		return sound_effects.process_mode

var ui_sound_process_mode: ProcessMode:
	set(value):
		ui_sound_effects.process_mode = value
	get:
		return ui_sound_effects.process_mode


var ambient_sound_process_mode: ProcessMode:
	set(value):
		ambient_sounds.process_mode = value
	get:
		return ambient_sounds.process_mode


var music_process_mode: ProcessMode:
	set(value):
		music.process_mode = value
	get:
		return music.process_mode


func _init() -> void:
	Engine.register_singleton("SoundManager", self)

	add_child(sound_effects)
	add_child(ui_sound_effects)
	add_child(ambient_sounds)
	add_child(music)

	self.sound_process_mode = PROCESS_MODE_PAUSABLE
	self.ui_sound_process_mode = PROCESS_MODE_ALWAYS
	self.ambient_sound_process_mode = PROCESS_MODE_ALWAYS
	self.music_process_mode = PROCESS_MODE_ALWAYS


#region Sounds


func get_sound_volume() -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(sound_effects.bus)))


func get_ui_sound_volume() -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(ui_sound_effects.bus)))


func set_sound_volume(volume_between_0_and_1: float) -> void:
	_show_shared_bus_warning()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(sound_effects.bus), linear_to_db(volume_between_0_and_1))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(ui_sound_effects.bus), linear_to_db(volume_between_0_and_1))


func play_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return sound_effects.play(resource, override_bus)


func play_sound_with_pitch(resource: AudioStream, pitch: float = 1.0, override_bus: String = "") -> AudioStreamPlayer:
	var player = sound_effects.play(resource, override_bus)
	player.pitch_scale = pitch
	return player


func stop_sound(resource: AudioStream) -> void:
	return sound_effects.stop(resource)


func play_ui_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	return ui_sound_effects.play(resource, override_bus)


func play_ui_sound_with_pitch(resource: AudioStream, pitch: float = 1.0, override_bus: String = "") -> AudioStreamPlayer:
	var player = ui_sound_effects.play(resource, override_bus)
	player.pitch_scale = pitch
	return player


func stop_ui_sound(resource: AudioStream) -> void:
	return ui_sound_effects.stop(resource)


func set_default_sound_bus(bus: String) -> void:
	sound_effects.bus = bus


func set_default_ui_sound_bus(bus: String) -> void:
	ui_sound_effects.bus = bus


#endregion

#region Ambient sound


func get_ambient_sound_volume() -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(ambient_sounds.bus)))


func set_ambient_sound_volume(volume_between_0_and_1: float) -> void:
	_show_shared_bus_warning()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(ambient_sounds.bus), linear_to_db(volume_between_0_and_1))


func play_ambient_sound(resource: AudioStream, fade_in_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	return ambient_sounds.play(resource, fade_in_duration, override_bus)


func stop_ambient_sound(resource: AudioStream, fade_out_duration: float = 0.0) -> void:
	ambient_sounds.stop(resource, fade_out_duration)


func stop_all_ambient_sounds(fade_out_duration: float = 0.0) -> void:
	ambient_sounds.stop_all(fade_out_duration)


func set_default_ambient_sound_bus(bus: String) -> void:
	ambient_sounds.bus = bus


#endregion

#region Music

func get_music_volume() -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(music.bus)))


func set_music_volume(volume_between_0_and_1: float) -> void:
	_show_shared_bus_warning()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(music.bus), linear_to_db(volume_between_0_and_1))


func play_music(resource: AudioStream, crossfade_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	return music.play(resource, 0.0,  0.0, crossfade_duration, override_bus)


func play_music_from_position(resource: AudioStream, position: float = 0.0, crossfade_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	return music.play(resource, position, 0.0, crossfade_duration, override_bus)


func play_music_at_volume(resource: AudioStream, volume: float = 0.0, crossfade_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	return music.play(resource, 0.0, volume, crossfade_duration, override_bus)


func play_music_from_position_at_volume(resource: AudioStream, position: float = 0.0, volume: float = 0.0, crossfade_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	return music.play(resource, position, volume, crossfade_duration, override_bus)


func get_music_track_history() -> Array:
	return music.track_history


func get_last_played_music_track() -> String:
	return music.track_history[0]


func is_music_playing(resource: AudioStream = null) -> bool:
	return music.is_playing(resource)


func is_music_track_playing(resource_path: String) -> bool:
	return music.is_track_playing(resource_path)


func get_currently_playing_music() -> Array:
	return music.get_currently_playing()


func get_currently_playing_music_tracks() -> Array:
	return music.get_current_tracks()


func pause_music(resource: AudioStream = null) -> void:
	music.pause(resource)


func resume_music(resource: AudioStream = null) -> void:
	music.resume(resource)


func stop_music(fade_out_duration: float = 0.0) -> void:
	music.stop(fade_out_duration)


func set_default_music_bus(bus: String) -> void:
	music.bus = bus


#endregion

#region helpers


func _show_shared_bus_warning() -> void:
	if music.bus == sound_effects.bus or music.bus == ui_sound_effects.bus:
		push_warning("Both music and sounds are using the same bus: %s" % music.bus)


#endregion
