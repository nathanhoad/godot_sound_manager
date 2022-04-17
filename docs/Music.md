# Music

- **`SoundManager.play_music(resource: AudioStream, crossfade_duration: int = 0, override_bus: String = "") -> AudioStreamPlayer`**

    Play some music with an optional fade in (or crossfade if something is already playing) and optionally specify which audio bus to use.

    This returns the `AudioStreamPlayer` that is playing the sound so you can make any other adjustments you need.

- **`SoundManager.is_music_playing(resource: AudioStream = null) -> bool`**

    Checks whether a specific audio resource is currently playing. If no resource is given it will tell you whether *anything* is currently playing.

- **`SoundManager.stop_music(fade_out_duration: int = 0) -> void`**

    Stop any music that's playing with an optional fade out.

- **`SoundManager.set_default_music_bus(bus: String) -> void`**

    Sets the default audio bus used for playing music.