extends CharacterBody2D


const SPEED = 1600


func _physics_process(delta):
	
	if position.x != 1116:
		position.x = 1116
		print(position)

	var direction = Input.get_axis("player 2 up", "player 2 down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED/2)

	move_and_slide()
