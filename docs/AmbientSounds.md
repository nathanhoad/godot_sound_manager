# Ambient Sounds

Ambient sounds are for playing continuous background soundscapes (atmospheric sounds like rain, machine humbs, etc).

- **`SoundManager.get_ambient_sound_volume() -> float:`**

  Get the volume for ambient sounds.

- **`SoundManager.set_ambient_sound_volume(volume_between_0_and_1: float) -> void:`**

  Sets the volume for sounds (both general and UI sounds) using a given float between 0 and 1.

- **`SoundManager.play_ambient_sound(resource: AudioStream, fade_in_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer`**

  Play an audio stream intended for continuous background sound.

  This returns the `AudioStreamPlayer` that is playing the sound so you can adjust the pitch or volume.

- **`SoundManager.stop_ambient_sound(resource: AudioStream, fade_out_duration: float = 0.0) -> void`**

  Stop a specific audio stream.

- **`SoundManager.stop_all_ambient_sounds(fade_out_duration: float = 0.0) -> void`**

  Stop all background audio streams.

- **`SoundManager.set_default_ambient_sound_bus(bus: String) -> void`**

  Sets the default audio bus used for playing ambient sounds.

## Pausing the game

By default, ambient sounds are paused when the game is paused. To change this you can set `SoundManager.ambient_sound_process_mode`. The value is of type `ProcessMode`.
