extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "Player 1 Score: " + str(Scores.player_1_score)
