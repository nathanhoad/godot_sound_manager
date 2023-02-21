# Music

- **`SoundManager.set_music_volume(volume_between_0_and_1: float) -> void:`**

    Sets the volume for music using a given float between 0 and 1.

- **`SoundManager.play_music(resource: AudioStream, crossfade_duration: int = 0, override_bus: String = "") -> AudioStreamPlayer`**

    Play some music with an optional fade in (or crossfade if something is already playing) and optionally specify which audio bus to use.

    This returns the `AudioStreamPlayer` that is playing the sound so you can make any other adjustments you need.

- **`SoundManager.play_music_at_volume(resource: AudioStream, volume: float = 0.0, crossfade_duration: int = 0, override_bus: String = "") -> AudioStreamPlayer`**

    Play some music at a given volume with an optional fade in (or crossfade if something is already playing) and optionally specify which audio bus to use.

    This returns the `AudioStreamPlayer` that is playing the sound so you can make any other adjustments you need.

- **`SoundManager.get_music_track_history() -> Array`**

    Get the list of recently played resource paths (capped at 50).

- **`SoundManager.get_last_played_music_track() -> String`**

    Get the last played resource path.

- **`SoundManager.is_music_playing(resource: AudioStream = null) -> bool`**

    Checks whether a specific audio resource is currently playing. If no resource is given it will tell you whether *anything* is currently playing.

- **`SoundManager.is_music_track_playing(resource_path: String) -> bool`**

    Checks whether a given audio resource path is currently playing.

- **`SoundManager.get_currently_playing_music() -> Array`**

    Get the list of currently playing audio streams.

- **`SoundManager.get_currently_playing_music_tracks() -> Array`**

    Get the list of currently playing audio stream resource paths.

- **`SoundManager.stop_music(fade_out_duration: int = 0) -> void`**

    Stop any music that's playing with an optional fade out.

- **`SoundManager.set_default_music_bus(bus: String) -> void`**

    Sets the default audio bus used for playing music.

## Pausing the game

By default, music is not paused when the game is paused. To change this you can set `SoundManager.music_process_mode`. The value is of type `ProcessMode`.