extends RichTextLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = Scores.restart_text_box_contents
