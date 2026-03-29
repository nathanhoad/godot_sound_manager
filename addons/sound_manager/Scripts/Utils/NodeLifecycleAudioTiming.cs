using Godot;
using System;

namespace CGT.Events
{
	[Flags]
	public enum NodeLifecycleAudioTiming
	{
		Null = 1 << 0,
		Ready = 1 << 1,
		EnterTree = 1 << 2,
		ExitTree = 1 << 3,
	}
}