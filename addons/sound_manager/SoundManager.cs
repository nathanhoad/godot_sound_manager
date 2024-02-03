using Godot;
using Godot.Collections;

namespace NathanHoad
{
    public partial class SoundManager : Node
    {
        private static Node instance;
        public static Node Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = (Node)Engine.GetSingleton("SoundManager");
                }
                return instance;
            }
        }


        public static ProcessModeEnum SoundProcessMode
        {
            get => ((Node)Instance.Get("sound_effects")).ProcessMode;
            set
            {
                ((Node)Instance.Get("sound_effects")).ProcessMode = value;
            }
        }

        public static ProcessModeEnum UISoundProcessMode
        {
            get => ((Node)Instance.Get("ui_sound_effects")).ProcessMode;
            set
            {
                ((Node)Instance.Get("ui_sound_effects")).ProcessMode = value;
            }
        }

        public static ProcessModeEnum AmbientSoundProcessMode
        {
            get => ((Node)Instance.Get("ambient_sounds")).ProcessMode;
            set
            {
                ((Node)Instance.Get("ambient_sounds")).ProcessMode = value;
            }
        }

        public static ProcessModeEnum MusicProcessMode
        {
            get => ((Node)Instance.Get("music")).ProcessMode;
            set
            {
                ((Node)Instance.Get("music")).ProcessMode = value;
            }
        }


        #region Sounds

        public static float GetSoundVolume()
        {
            return (float)Instance.Call("get_sound_volume");
        }


        public static float GetUISoundVolume()
        {
            return (float)Instance.Call("get_ui_sound_volume");
        }


        public static void SetSoundVolume(float volume)
        {
            Instance.Call("set_sound_volume", volume);
        }


        public static AudioStreamPlayer PlaySound(AudioStream resource, string overrideBus = "")
        {
            return (AudioStreamPlayer)Instance.Call("play_sound", resource, overrideBus);
        }


        public static AudioStreamPlayer PlaySoundWithPitch(AudioStream resource, float pitch, string overrideBus = "")
        {
            return (AudioStreamPlayer)Instance.Call("play_sound_with_pitch", resource, pitch, overrideBus);
        }


        public static void StopSound(AudioStream resource)
        {
            Instance.Call("stop_sound", resource);
        }


        public static AudioStreamPlayer PlayUISound(AudioStream resource, string overrideBus = "")
        {
            return (AudioStreamPlayer)Instance.Call("play_ui_sound", resource, overrideBus);
        }


        public static AudioStreamPlayer PlayUISoundWithPitch(AudioStream resource, float pitch, string overrideBus = "")
        {
            return (AudioStreamPlayer)Instance.Call("play_ui_sound_with_pitch", resource, pitch, overrideBus);
        }


        public static void StopUISound(AudioStream resource)
        {
            Instance.Call("stop_ui_sound", resource);
        }


        public static void SetDefaultSoundBus(string bus)
        {
            Instance.Call("set_default_sound_bus", bus);
        }


        public static void SetDefaultUISoundBus(string bus)
        {
            Instance.Call("set_default_ui_sound_bus", bus);
        }

        #endregion


        #region Ambient sounds

        public static AudioStreamPlayer PlayAmbientSound(AudioStream resource, float fadeInDuration, string overrideBus = "")
        {
            return (AudioStreamPlayer)Instance.Call("play_ambient_sound", resource, fadeInDuration);
        }


        public static void StopAmbientSound(AudioStream resource, float fadeOutDuration)
        {
            Instance.Call("stop_ambient_sound", resource, fadeOutDuration);
        }


        public static void StopAllAmbientSounds(float fadeOutDuration)
        {
            Instance.Call("stop_all_ambient_sounds", fadeOutDuration);
        }


        public static void SetDefaultAmbientSoundBus(string bus)
        {
            Instance.Call("set_default_ambient_sound_bus", bus);
        }

        #endregion


        #region  Music

        public static float GetMusicVolume()
        {
            return (float)Instance.Call("get_music_volume");
        }


        public static void SetMusicVolume(float volume)
        {
            Instance.Call("set_music_volume", volume);
        }


        public static AudioStreamPlayer PlayMusic(AudioStream resource, float crossFadeDuration = 0.0f, string overrideBus = "")
        {
            return (AudioStreamPlayer)Instance.Call("play_music", resource, crossFadeDuration, overrideBus);
        }


        public static AudioStreamPlayer PlayMusicFromPosition(AudioStream resource, float position, float crossFadeDuration = 0.0f, string overrideBus = "")
        {
            return (AudioStreamPlayer)Instance.Call("play_music_from_position", resource, position, crossFadeDuration, overrideBus);
        }


        public static AudioStreamPlayer PlayMusicAtVolume(AudioStream resource, float volume, float crossFadeDuration = 0.0f, string overrideBus = "")
        {
            return (AudioStreamPlayer)Instance.Call("play_music_at_volume", resource, volume, crossFadeDuration, overrideBus);
        }

        public static AudioStreamPlayer PlayMusicFromPositionAtVolume(AudioStream resource, float position, float volume, float crossFadeDuration = 0.0f, string overrideBus = "")
        {
            return (AudioStreamPlayer)Instance.Call("play_music_from_position_at_volume", resource, position, volume, crossFadeDuration, overrideBus);
        }


        public static Array<string> GetMusicTrackHistory()
        {
            return (Array<string>)Instance.Call("get_music_track_history");
        }


        public static string GetLastPlayedMusicTrack()
        {
            return (string)Instance.Call("get_last_played_music_track");
        }


        public static bool IsMusicPlaying(AudioStream resource = null)
        {
            return (bool)Instance.Call("is_music_playing", resource);
        }


        public static bool IsMusicTrackPlaying(string resource_path)
        {
            return (bool)Instance.Call("is_music_track_playing", resource_path);
        }


        public static Array<AudioStream> GetCurrentlyPlayingMusic()
        {
            return (Array<AudioStream>)Instance.Call("get_currently_playing_music");
        }


        public static Array<string> GetCurrentlyPlayingTracks()
        {
            return (Array<string>)Instance.Call("get_currently_playing_tracks");
        }


        public static void PauseMusic(AudioStream resource = null)
        {
            Instance.Call("pause_music", resource);
        }


        public static void ResumeMusic(AudioStream resource = null)
        {
            Instance.Call("resume_music", resource);
        }


        public static void StopMusic(float fadeOutDuration = 0.0f)
        {
            Instance.Call("stop_music", fadeOutDuration);
        }


        public static void SetDefaultMusicBus(string bus)
        {
            Instance.Call("set_default_music_bus", bus);
        }

        #endregion
    }
}
