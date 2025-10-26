using Godot;
using System;

public partial class DestroyOnContact : Area2D
{
    public override void _EnterTree()
    {
		base._EnterTree();
		ToggleSubs(true);
    }

	protected virtual void ToggleSubs(bool on)
    {
		if (on)
        {
			BodyEntered += OnBodyEntered;
        }
		else
        {
			BodyEntered -= OnBodyEntered;
        }
	}

    private void OnBodyEntered(Node2D body)
    {
		QueueFree();
    }

    public override void _ExitTree()
    {
		base._ExitTree();
		ToggleSubs(false);
    }

}
