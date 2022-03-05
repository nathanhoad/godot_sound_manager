# Sound effects

Playing sound effects is broken up into playing general sounds (ie. in the game world) and playing user interface sounds. The reasoning behind this is that you might have your audio buses set up to include local modifiers (eg. being underwater) for local sounds where you wouldn't want your UI sounds being affected.

- **`SoundManager.play_sound(resource: AudioStream, override_bus: String = "")`**

    Play an audio stream intended for an action within the game world. Optionally specify which audio bus you want to use for this sound.

    This returns the `AudioStreamPlayer` that is playing the sound so you can adjust the pitch or volume.

- **`SoundManager.play_ui_sound(resource: AudioStream, override_bus: String = "")`**

    Play an audio stream intended for the user interface. Optionally specify which audio bus you want to use for this sound.

    This returns the `AudioStreamPlayer` that is playing the sound so you can adjust the pitch or volume.

- **`SoundManager.set_default_sound_bus(bus: String)`**

    Sets the default audio bus used for playing sounds.

- **`SoundManager.set_default_ui_sound_bus(bus: String)`**

    Sets the default audio bus used for playing UI sounds.