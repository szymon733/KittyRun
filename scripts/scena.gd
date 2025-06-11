extends Node2D

var bomb_scene = preload("res://sceny/bomb.tscn")
var dog_scene = preload("res://sceny/dog.tscn")
var trashcan_scene = preload("res://sceny/trashcan.tscn")
var obstacle_types := [bomb_scene, dog_scene, trashcan_scene]
var obstacles : Array




const KITTY_START_POS := Vector2i(156,-33)
const CAM_START_POS := Vector2i(470,-226)
var score : int
const SCORE_MODIFIER : int = 10
var high_score : int
var speed : float
const START_SPEED : float = 10.0
const MAX_SPEED : int =25
var screen_size : Vector2i
var ground_height : int
var game_running : bool
var last_obs






# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	$GAMEOVER.get_node("Button").pressed.connect(new_game)
	new_game()
	
func new_game():
	score = 0 
	show_score()
	get_tree().paused = false
	$Kitty.position = KITTY_START_POS
	$Kitty.velocity = Vector2i(0, 0)
	$Camera2D.position = CAM_START_POS
	$Ground.position=Vector2i(-112, -536)
	
	$SCORE.get_node("StartLabel").show()
	$GAMEOVER.hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		speed = START_SPEED + score / 5000
		if speed > MAX_SPEED:
			speed = MAX_SPEED
		generate_obs()
		
		
		
		
		$Kitty.position.x += speed
		$Camera2D.position.x += speed
		$Area2D.position.x += speed

		score += speed
		show_score()

		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$SCORE.get_node("StartLabel").hide()


func generate_obs():
	if obstacles.is_empty() or last_obs.position.x < score + randi_range(300,500):
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var obs
		var max_obs = 3
		for i in range(randi() % max_obs + 1):
			obs = obs_type.instantiate()
			var obs_height = obs.get_node("Sprite2D").texture.get_height()
			var obs_scale = obs.get_node("Sprite2D").scale
			var obs_x : int = screen_size.x + score + 100 + (i * 100)
			var obs_y : int = screen_size.y - ground_height - (obs_height * obs_scale.y / 2) + 100
			last_obs = obs
			add_obs(obs, obs_x, obs_y)

func add_obs(obs, x, y):
	obs.position = Vector2i(x,y)
	add_child(obs)
	obstacles.append(obs)

func remove_obs(obs):
	obs.queue_free()
	obstacles.erase(obs)
	

func show_score():
	$SCORE.get_node("Score Label").text = "SCORE: " + str(score/SCORE_MODIFIER)

func check_high_score():
	if score > high_score:
		high_score = score
		#$HUD.get_node("HighScoreLabel").text = "HIGH SCORE: " + str(high_score / SCORE_MODIFIER)

func hit_obs(body):
	if body.name == "Kitty":
		print("Collision")

func game_over():
	check_high_score()
	get_tree().paused = true
	game_running = false
	$GAMEOVER.show()
