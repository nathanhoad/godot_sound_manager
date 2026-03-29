using CGT.Events;
using Godot;

namespace NathanHoad.SoundManagement
{
	[GlobalClass]
	public partial class QuickPlayAudio : Node
	{
		[Export(PropertyHint.Flags)]
		protected NodeLifecycleAudioTiming _timing;
		// ^Best set this to null when you want this to start playing when called upon by another script
		[Export] protected AudioStream _audio;
		[Export] protected AudioType _audioType = AudioType.BGMusic;
		[Export] protected float _crossfadeDur = 1f;

		public override void _Ready()
		{
			base._Ready();
			PlayAudioIfTimingIs(NodeLifecycleAudioTiming.Ready);
		}

		protected virtual void PlayAudioIfTimingIs(NodeLifecycleAudioTiming currentTiming)
		{
			bool correctTiming = (_timing & currentTiming) > 0;
			if (!correctTiming)
			{
				return;
			}

			Play();
		}

		public virtual void Play()
		{
			switch (_audioType)
			{
				case AudioType.BGMusic:
					SoundManager.PlayMusic(_audio, _crossfadeDur); break;
				case AudioType.SoundFX:
					SoundManager.PlaySound(_audio); break;
				default:
					GD.PrintErr($"Unknown audio type {_audioType}"); break;
			}
		}

		public override void _EnterTree()
		{
			base._EnterTree();
			PlayAudioIfTimingIs(NodeLifecycleAudioTiming.EnterTree);
		}

		public override void _ExitTree()
		{
			base._ExitTree();
			PlayAudioIfTimingIs(NodeLifecycleAudioTiming.ExitTree);
		}

	}
}