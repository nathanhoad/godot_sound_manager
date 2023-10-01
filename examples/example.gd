extends Control


@export var sound_sample: AudioStream
@export var music_sample: AudioStream


@onready var sound_volume_label: Label = $Sound/SoundVolume
@onready var music_volume_label: Label = $Music/MusicVolume


func _ready() -> void:
	SoundManager.set_sound_volume(0.5)
	sound_volume_label.text = "50%"
	SoundManager.set_music_volume(0.5)
	music_volume_label.text = "50%"


func _on_play_sound_pressed() -> void:
	SoundManager.play_sound(sound_sample)


func _on_volume_down_pressed() -> void:
	var next_volume: float = clamp(SoundManager.get_sound_volume() - 0.1, 0, 1)
	SoundManager.set_sound_volume(next_volume)
	sound_volume_label.text = "%d%%" % [round(next_volume * 100)]
	SoundManager.play_sound(sound_sample)


func _on_volume_up_pressed() -> void:
	var next_volume: float = clamp(SoundManager.get_sound_volume() + 0.1, 0, 1)
	SoundManager.set_sound_volume(next_volume)
	sound_volume_label.text = "%d%%" % [round(next_volume * 100)]
	SoundManager.play_sound(sound_sample)


func _on_play_music_pressed() -> void:
	SoundManager.play_music(music_sample)


func _on_stop_music_pressed() -> void:
	SoundManager.stop_music()


func _on_music_volume_down_pressed() -> void:
	var next_volume: float = clamp(SoundManager.get_music_volume() - 0.1, 0, 1)
	SoundManager.set_music_volume(next_volume)
	music_volume_label.text = "%d%%" % [round(next_volume * 100)]


func _on_music_volume_up_pressed() -> void:
	var next_volume: float = clamp(SoundManager.get_music_volume() + 0.1, 0, 1)
	SoundManager.set_music_volume(next_volume)
	music_volume_label.text = "%d%%" % [round(next_volume * 100)]


func _on_play_sound_random_pitch_pressed() -> void:
	SoundManager.play_sound_with_pitch(sound_sample, randf_range(0.8, 1.2))
