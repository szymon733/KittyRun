using Godot;
using System;

public partial class Kotekscena : CharacterBody2D
{
    [Export] public float Speed = 200f;
    [Export] public float JumpVelocity = -400f;
    [Export] public float Gravity = 800f;

    public override void _PhysicsProcess(double delta)
    {
        Vector2 velocity = Velocity;

        // Apply gravity
        if (!IsOnFloor())
            velocity.Y += Gravity * (float)delta;

        // Left/right movement
        velocity.X = 0;
        if (Input.IsActionPressed("ui_left"))
            velocity.X -= Speed;
        if (Input.IsActionPressed("ui_right"))
            velocity.X += Speed;

        // Jumping
        if (Input.IsActionJustPressed("ui_accept") && IsOnFloor())
            velocity.Y = JumpVelocity;

        Velocity = velocity;
        MoveAndSlide();
    }
}
