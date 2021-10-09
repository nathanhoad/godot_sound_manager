![SayWhat logo](logo.svg)

# Godot Sound Manager

A simple music and sound effect player for the [Godot Engine](https://godotengine.org/).

Features:

- Pooled audio players
- Handles music crossfades
- Autodetect probable audio buses for both sounds and music

## Usage

Copy the `sound_manager` directory into your `res://addons/` directory.

Enable `SoundManager` in project plugins.

- **`SoundManager.play_sound(resource: AudioStream, override_bus: String = "")`**

    Play an audio stream. Optionally specify which audio bus you want to use for this sound.

- **`SoundManager.set_default_sound_bus(bus: String)`**

    Sets the default audio bus used for playing sounds.

- **`SoundManager.play_music(resource: AudioStream, crossfade_duration: int = 0, override_bus: String = "")`**

    Play some music with an optional fade in (or crossfade if something is already playing) and optionally specify which audio bus to use.

- **`SoundManager.stop_music(fade_out_duration: int = 0)`**

    Stop any music that's playing with an optional fade out.

- **`SoundManager.set_default_music_bus(bus: String)`**

    Sets the default audio bus used for playing music.

## Contributors

[Nathan Hoad](https://nathanhoad.net)

## License

Licensed under the MIT license, see `LICENSE` for more information.