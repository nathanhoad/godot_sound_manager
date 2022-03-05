# Music

- **`SoundManager.play_music(resource: AudioStream, crossfade_duration: int = 0, override_bus: String = "")`**

    Play some music with an optional fade in (or crossfade if something is already playing) and optionally specify which audio bus to use.

    This returns the `AudioStreamPlayer` that is playing the sound so you can make any other adjustments you need.

- **`SoundManager.stop_music(fade_out_duration: int = 0)`**

    Stop any music that's playing with an optional fade out.

- **`SoundManager.set_default_music_bus(bus: String)`**

    Sets the default audio bus used for playing music.