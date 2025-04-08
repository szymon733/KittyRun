using Godot;
using System;

public partial class Kotekscena : Sprite2D
{
    [Export] private float Speed = 200f; // Movement speed
    private Vector2 _velocity = Vector2.Zero;

    public override void _Process(double delta)
    {
        _velocity = Vector2.Zero;

        if (Input.IsActionPressed("ui_right"))
            _velocity.X += 1;
        if (Input.IsActionPressed("ui_left"))
            _velocity.X -= 1;
        if (Input.IsActionPressed("ui_down"))
            _velocity.Y += 1;
        if (Input.IsActionPressed("ui_up"))
            _velocity.Y -= 1;

        if (_velocity.Length() > 0)
            _velocity = _velocity.Normalized() * Speed;

        Position += _velocity * (float)delta;
    }
}
