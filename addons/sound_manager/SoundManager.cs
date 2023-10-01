using Godot;
using Godot.Collections;

namespace NathanHoad
{

  public partial class SoundManager : Node
  {

    #region Sounds

    public static float GetSoundVolume()
    {
      return (float)GetSoundManager().Call("get_sound_volume");
    }


    public static float GetUISoundVolume()
    {
      return (float)GetSoundManager().Call("get_ui_sound_volume");
    }


    public static void SetSoundVolume(float volume)
    {
      GetSoundManager().Call("set_sound_volume", volume);
    }


    public static AudioStreamPlayer PlaySound(AudioStream resource, string overrideBus = "")
    {
      return (AudioStreamPlayer)GetSoundManager().Call("play_sound", resource, overrideBus);
    }


    public static AudioStreamPlayer PlayUISound(AudioStream resource, string overrideBus = "")
    {
      return (AudioStreamPlayer)GetSoundManager().Call("play_ui_sound", resource, overrideBus);
    }


    public static void SetDefaultSoundBus(string bus)
    {
      GetSoundManager().Call("set_default_sound_bus", bus);
    }


    public static void SetDefaultUISoundBus(string bus)
    {
      GetSoundManager().Call("set_default_ui_sound_bus", bus);
    }

    #endregion

    #region  Music

    public static float GetMusicVolume()
    {
      return (float)GetSoundManager().Call("get_music_volume");
    }


    public static void SetMusicVolume(float volume)
    {
      GetSoundManager().Call("set_music_volume", volume);
    }


    public static AudioStreamPlayer PlayMusic(AudioStream resource, float crossFadeDuration = 0.0f, string overrideBus = "")
    {
      return (AudioStreamPlayer)GetSoundManager().Call("play_music", resource, crossFadeDuration, overrideBus);
    }


    public static AudioStreamPlayer PlayMusicAtVolume(AudioStream resource, float volume, float crossFadeDuration = 0.0f, string overrideBus = "")
    {
      return (AudioStreamPlayer)GetSoundManager().Call("play_music_at_volume", resource, volume, crossFadeDuration, overrideBus);
    }


    public static Array<string> GetMusicTrackHistory()
    {
      return (Array<string>)GetSoundManager().Call("get_music_track_history");
    }


    public static string GetLastPlayedMusicTrack()
    {
      return (string)GetSoundManager().Call("get_last_played_music_track");
    }


    public static bool IsMusicPlaying(AudioStream resource = null)
    {
      return (bool)GetSoundManager().Call("is_music_playing", resource);
    }


    public static bool IsMusicTrackPlaying(string resource_path)
    {
      return (bool)GetSoundManager().Call("is_music_track_playing", resource_path);
    }


    public static Array<AudioStream> GetCurrentlyPlayingMusic()
    {
      return (Array<AudioStream>)GetSoundManager().Call("get_currently_playing_music");
    }


    public static Array<string> GetCurrentlyPlayingTracks()
    {
      return (Array<string>)GetSoundManager().Call("get_currently_playing_tracks");
    }


    public static void PauseMusic(AudioStream resource = null)
    {
      GetSoundManager().Call("pause_music", resource);
    }


    public static void ResumeMusic(AudioStream resource = null)
    {
      GetSoundManager().Call("resume_music", resource);
    }


    public static void StopMusic(float fadeOutDuration = 0.0f)
    {
      GetSoundManager().Call("stop_music", fadeOutDuration);
    }


    public static void SetDefaultMusicBus(string bus)
    {
      GetSoundManager().Call("set_default_music_bus", bus);
    }

    #endregion


    private static Node GetSoundManager()
    {
      return Engine.GetSingleton("SoundManager") as Node;
    }
  }
}