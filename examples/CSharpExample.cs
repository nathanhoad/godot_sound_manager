using Godot;
using NathanHoad;
using System;

public partial class CSharpExample : Control
{
  [Export]
  public AudioStream SoundSample = null;

  [Export]
  public AudioStream MusicSample = null;

  Button playSoundButton;
  Button soundVolumeDownButton;
  Button soundVolumeUpButton;
  Label soundVolumeLabel;

  Button playMusicButton;
  Button stopMusicButton;
  Button musicVolumeDownButton;
  Button musicVolumeUpButton;
  Label musicVolumeLabel;


  public override void _Ready()
  {
    base._Ready();

    // Sound

    SoundManager.SetSoundVolume(0.5f);
    soundVolumeLabel = GetNode<Label>("Sound/Volume");
    soundVolumeLabel.Text = "50%";

    playSoundButton = GetNode<Button>("Sound/PlaySound");
    playSoundButton.Pressed += () =>
    {
      SoundManager.PlaySound(SoundSample);
    };

    soundVolumeDownButton = GetNode<Button>("Sound/VolumeDown");
    soundVolumeDownButton.Pressed += () =>
    {
      float nextVolume = Math.Clamp(SoundManager.GetSoundVolume() - 0.1f, 0.0f, 1.0f);
      SoundManager.SetSoundVolume(nextVolume);
      soundVolumeLabel.Text = $"{Math.Round(nextVolume * 100)}%";
      SoundManager.PlaySound(SoundSample);
    };
    soundVolumeUpButton = GetNode<Button>("Sound/VolumeUp");
    soundVolumeUpButton.Pressed += () =>
    {
      float nextVolume = Math.Clamp(SoundManager.GetSoundVolume() + 0.1f, 0.0f, 1.0f);
      SoundManager.SetSoundVolume(nextVolume);
      soundVolumeLabel.Text = $"{Math.Round(nextVolume * 100)}%";
      SoundManager.PlaySound(SoundSample);
    };

    // Music

    SoundManager.SetMusicVolume(0.5f);
    musicVolumeLabel = GetNode<Label>("Music/Volume");
    musicVolumeLabel.Text = "50%";

    playMusicButton = GetNode<Button>("Music/PlayMusic");
    playMusicButton.Pressed += () =>
    {
      SoundManager.PlayMusic(MusicSample);
    };

    stopMusicButton = GetNode<Button>("Music/StopMusic");
    stopMusicButton.Pressed += () =>
    {
      SoundManager.StopMusic();
    };

    musicVolumeDownButton = GetNode<Button>("Music/VolumeDown");
    musicVolumeDownButton.Pressed += () =>
    {
      float nextVolume = Math.Clamp(SoundManager.GetMusicVolume() - 0.1f, 0.0f, 1.0f);
      SoundManager.SetMusicVolume(nextVolume);
      musicVolumeLabel.Text = $"{Math.Round(nextVolume * 100)}%";
    };
    musicVolumeUpButton = GetNode<Button>("Music/VolumeUp");
    musicVolumeUpButton.Pressed += () =>
    {
      float nextVolume = Math.Clamp(SoundManager.GetMusicVolume() + 0.1f, 0.0f, 1.0f);
      SoundManager.SetMusicVolume(nextVolume);
      musicVolumeLabel.Text = $"{Math.Round(nextVolume * 100)}%";
    };
  }
}
