class_name Paddle

extends CharacterBody2D


const TOP_SPEED = 1600.0

func _physics_process(delta):

	if position.x != 36:
		position.x =36
	var direction = Input.get_axis("player 1 up", "player 1  down")
	if direction:
		velocity.y = direction * TOP_SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, TOP_SPEED)

	move_and_slide()
