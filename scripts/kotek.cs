using Godot;
using System;

public partial class kotek : CharacterBody2D
{
    [Export] public float Speed = 200f;
    [Export] public float JumpVelocity = -400f;
    [Export] public float Gravity = 800f;

    private Sprite2D _sprite;

    public override void _Ready()
    {
        _sprite = GetNode<Sprite2D>("Sprite2D"); // Make sure this matches your sprite's name!
    }

    public override void _PhysicsProcess(double delta)
    {
        Vector2 velocity = Velocity;

        // Apply gravity
        if (!IsOnFloor())
            velocity.Y += Gravity * (float)delta;

        // Left/right movement + sprite flip
        velocity.X = 0;

        if (Input.IsActionPressed("ui_left"))
        {
            velocity.X -= Speed;
            _sprite.FlipH = true;
        }
        if (Input.IsActionPressed("ui_right"))
        {
            velocity.X += Speed;
            _sprite.FlipH = false;
        }

        // Jumping
        if (Input.IsActionJustPressed("ui_accept") && IsOnFloor())
            velocity.Y = JumpVelocity;

        Velocity = velocity;
        MoveAndSlide();
    }
}
