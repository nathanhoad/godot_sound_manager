# Sound effects

Playing sound effects is broken up into playing general sounds (ie. in the game world) and playing user interface sounds. The reasoning behind this is that you might have your audio buses set up to include local modifiers (eg. being underwater) for local sounds where you wouldn't want your UI sounds being affected.

- **`SoundManager.set_sound_volume(volume_between_0_and_1: float) -> void:`**

    Sets the volume for sounds (both general and UI sounds) using a given float between 0 and 1.


- **`SoundManager.play_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer`**

    Play an audio stream intended for an action within the game world. Optionally specify which audio bus you want to use for this sound.

    This returns the `AudioStreamPlayer` that is playing the sound so you can adjust the pitch or volume.

- **`SoundManager.play_ui_sound(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer`**

    Play an audio stream intended for the user interface. Optionally specify which audio bus you want to use for this sound.

    This returns the `AudioStreamPlayer` that is playing the sound so you can adjust the pitch or volume.

- **`SoundManager.set_default_sound_bus(bus: String) -> void`**

    Sets the default audio bus used for playing sounds.

- **`SoundManager.set_default_ui_sound_bus(bus: String) -> void`**

    Sets the default audio bus used for playing UI sounds.

## Pausing the game

By default, general sounds are paused when the game is paused and UI sounds are not. To change this you can set `SoundManager.sound_process_mode` and/or `SoundManager.ui_sound_process_mode`. The values are of type `ProcessMode`.