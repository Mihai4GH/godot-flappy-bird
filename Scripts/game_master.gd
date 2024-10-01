extends Node

@onready var bird = $"../Bird" as Bird
@onready var pipe_spawner: PipeSpawner = $"../PipeSpawner"
@onready var ground: Ground = $"../Ground"
@onready var fade: Fade  = $"../Fade"
@onready var ui: UI = $"../UI"

var points = 0

func _ready():
	bird.game_started.connect(on_game_started)
	ground.bird_crashed.connect(game_end)
	pipe_spawner.bird_crashed.connect(game_end)
	pipe_spawner.point_scored.connect(point_scored)
	
func on_game_started():
	pipe_spawner.start_spawning_pipes()

func game_end():
	ground.stop()
	pipe_spawner.stop()
	bird.kill()
	if fade != null:
		fade.play()
	ui.on_game_over()
		
func point_scored():
	points += 1
	ui.update_points(points) 
