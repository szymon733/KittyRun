extends Node2D

const KITTY_START_POS := Vector2i(156,-33)
const CAM_START_POS := Vector2i(470,-226)
var score : int
const SCORE_MODIFIER : int = 10
var speed : float
const START_SPEED : float = 10.0
const MAX_SPEED : int =25
var screen_size : Vector2i
var game_running : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	new_game()
func new_game():
	score = 0
	show_score()
	$Kitty.position = KITTY_START_POS
	$Kitty.velocity = Vector2i(0, 0)
	$Camera2D.position = CAM_START_POS
	$Ground.position=Vector2i(-112, -536)

	$SCORE.get_node("StartLabel").show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		speed = START_SPEED + score / 5000
		if speed > MAX_SPEED:
			speed = MAX_SPEED
		
		$Kitty.position.x += speed
		$Camera2D.position.x += speed

		score += speed
		show_score()

		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$SCORE.get_node("StartLabel").hide()

func show_score():
	$SCORE.get_node("Score Label").text = "SCORE: " + str(score/SCORE_MODIFIER)
