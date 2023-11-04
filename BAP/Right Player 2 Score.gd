extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "Player 2 Score: " + str(Scores.player_2_score)
