using Godot;
using System;

public partial class RegeneratePeriodically : Node
{
	[Export] protected Node2D _initialNode;
	[Export] protected PackedScene _toGenerate;
	[Export] protected float _regenDelay = 1;

    public override void _Ready()
    {
		base._Ready();
		_nodeToWatch = _initialNode;
		initNodePos = _initialNode.GlobalPosition;
    }

	protected Node2D _nodeToWatch;
	protected Vector2 initNodePos;

	public override void _Process(double delta)
	{
		if (!_generating && !IsInstanceValid(_nodeToWatch))
		{
			_generating = true;
			RegenerateAfterDelay();
		}
	}

	protected bool _generating = false;

	protected virtual async void RegenerateAfterDelay()
	{
		GD.Print("Regenerating...");
		await WaitForSeconds(_regenDelay);
		_nodeToWatch = (Node2D)_toGenerate.Instantiate();
		_nodeToWatch.GlobalPosition = initNodePos;
		AddChild(_nodeToWatch);
		_generating = false;
		GD.Print("Regeneration done!");
	}
	
	protected SignalAwaiter WaitForSeconds(float duration)
	{
		var tree = GetTree();
		var timer = tree.CreateTimer(duration);
		var eventName = "timeout";
		return ToSignal(timer, eventName);
	}
}
