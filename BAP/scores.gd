extends Node


var player_1_score =0
var player_2_score =0
var current_ball_points = 0
var restart_text = "Press Space to
	play again!"
var restart_text_box_contents = ""

var max_score := 43

# Called when the node enters the scene tree for the first time

# Works here but not if placed in main.gd. no idea why
func _process(delta):
	if Input.is_action_just_pressed("reset_game"):
		reset_playfield()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func reset_playfield():
	get_tree().reload_current_scene()
	player_1_score = 0
	player_2_score = 0
			
