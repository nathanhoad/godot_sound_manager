using Godot;
using System;

namespace NathanHoad.SoundManagement.Examples
{
	public partial class FreeMovement : CharacterBody2D
	{
		[Export] protected float _moveSpeed = 100;
		[Export] protected float _acceleration = 50;
		[Export] protected float _braking = 20;

		
		public override void _PhysicsProcess(double delta)
		{
			base._PhysicsProcess(delta);

			Vector2 newVel = Velocity;
			var _moveInput = Input.GetAxis("move_left", "move_right");
			var _vertInput = Input.GetAxis("move_up", "move_down");
			
			SmoothlyAccelOrDecel();
			void SmoothlyAccelOrDecel()
			{
				if (_moveInput != 0)
				{
					newVel.X = Mathf.Lerp(newVel.X, _moveInput * _moveSpeed, _acceleration * (float)delta);
				}
				else
				{
					newVel.X = Mathf.Lerp(newVel.X, 0, _braking * (float)delta);
				}

				if (_vertInput != 0)
				{
					newVel.Y = Mathf.Lerp(newVel.Y, _vertInput * _moveSpeed, _acceleration * (float)delta);
				}
				else
				{
					newVel.Y = Mathf.Lerp(newVel.Y, 0, _braking * (float)delta);
				}
			}

			Velocity = newVel;
			MoveAndSlide();
		}

	}
}