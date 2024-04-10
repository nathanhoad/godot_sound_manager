# Music

- **`SoundManager.get_music_volume() -> float:`**

  Get the volume for music.

- **`SoundManager.set_music_volume(volume_between_0_and_1: float) -> void:`**

  Sets the volume for music using a given float between 0 and 1.

- **`SoundManager.play_music(resource: AudioStream, crossfade_duration: int = 0, override_bus: String = "") -> AudioStreamPlayer`**

  Play some music with an optional fade in (or crossfade if something is already playing) and optionally specify which audio bus to use.

  This returns the `AudioStreamPlayer` that is playing the sound so you can make any other adjustments you need.

- **`SoundManager.play_music_from_position(resource: AudioStream, position: float = 0.0, crossfade_duration: int = 0, override_bus: String = "") -> AudioStreamPlayer`**

  Play some music from a certain point in the audio file with an optional fade in (or crossfade if something is already playing) and optionally specify which audio bus to use.

  This returns the `AudioStreamPlayer` that is playing the sound so you can make any other adjustments you need.

- **`SoundManager.play_music_at_volume(resource: AudioStream, volume: float = 0.0, crossfade_duration: int = 0, override_bus: String = "") -> AudioStreamPlayer`**

  Play some music at a given volume with an optional fade in (or crossfade if something is already playing) and optionally specify which audio bus to use.

  This returns the `AudioStreamPlayer` that is playing the sound so you can make any other adjustments you need.

- **`SoundManager.play_music_from_position_at_volume(resource: AudioStream, position: floatm = 0.0 volume: float = 0.0, crossfade_duration: int = 0, override_bus: String = "") -> AudioStreamPlayer`**

  Play some music from a certain point in the audio file at a given volume with an optional fade in (or crossfade if something is already playing) and optionally specify which audio bus to use.

  This returns the `AudioStreamPlayer` that is playing the sound so you can make any other adjustments you need.

- **`SoundManager.get_music_track_history() -> Array`**

  Get the list of recently played resource paths (capped at 50).

- **`SoundManager.get_last_played_music_track() -> String`**

  Get the last played resource path.

- **`SoundManager.is_music_playing(resource: AudioStream = null) -> bool`**

  Checks whether a specific audio resource is currently playing. If no resource is given it will tell you whether _anything_ is currently playing.

- **`SoundManager.is_music_track_playing(resource_path: String) -> bool`**

  Checks whether a given audio resource path is currently playing.

- **`SoundManager.get_currently_playing_music() -> Array`**

  Get the list of currently playing audio streams.

- **`SoundManager.get_currently_playing_music_tracks() -> Array`**

  Get the list of currently playing audio stream resource paths.

- **`func pause_music(resource: AudioStream = null) -> void:`**

  Pause either a specific piece of music or all current music.

- **`func resume_music(resource: AudioStream = null) -> void:`**

  Resume either a specific piece of music or all current music.

- **`SoundManager.set_default_music_bus(bus: String) -> void`**

  Sets the default audio bus used for playing music.

- **`SoundManager.stop_music(fade_out_duration: int = 0) -> void`**

  Stop any music that's playing with an optional fade out.

## Pausing the game

By default, music is not paused when the game is paused. To change this you can set `SoundManager.music_process_mode`. The value is of type `ProcessMode`.

You can also make use of the `pause_music` method described above.
