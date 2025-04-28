extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800

func _physics_process(delta):
	velocity.y += GRAVITY * delta  # apply gravity

	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_SPEED  # only allow jump when on ground

	move_and_slide()  # actually apply velocity to movement
