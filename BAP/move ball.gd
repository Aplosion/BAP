class_name Ball
extends AnimatableBody2D

@export_range(0, 1000, 10, 'suffix:px/s')
var speed: float

@export_range(0, 1000, 10, 'suffix:px/s')
var max_speed: float

@export_range(0, 1000, 10, 'suffix:px/s')
var acceleration: float

var spawn_position: Vector2

var current_speed: float

var velocity: Vector2

var acceleration_ratio = 1.01

var paddle_acceleration_ratio = 1.03

var paddle_bounces: int

func _ready() -> void:
	spawn_position = global_position
	reset_speed_and_position()


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("reset_position"):
		reset_speed_and_position()
		
	
	var collision = move_and_collide(velocity * delta)
	var collider = collision.get_collider() if collision else null
	
	if collider is Paddle:
		_bounce_off_paddle(collision)
	elif collider is Brick:
		Scores.current_ball_points +=1
		print("hit brick")
		_bounce_off_wall(collision)
		collider.set_collision_layer_value(1,false)
		collider.hide()
	elif collider:
		_bounce_off_wall(collision)


func reset_speed_and_position() -> void:
	current_speed = speed
	position = spawn_position
	_randomize_direction()

func play_bounce_sound():
	$"../AudioStreamPlayer".play()

func _bounce_off_wall(collision: KinematicCollision2D) -> void:
	play_bounce_sound()
	limit_speed()
	velocity = velocity.bounce(collision.get_normal())* acceleration_ratio
	
func _bounce_off_paddle(collision: KinematicCollision2D) -> void:
	play_bounce_sound()
#	print(velocity)
	limit_speed()
	velocity = velocity.bounce(collision.get_normal())* paddle_acceleration_ratio
#	paddle_bounces +=1
#	print(paddle_bounces)

func _randomize_direction() -> void:
	var random_direction = Vector2()
	
	# Exclude directions parallel to the X and Y axes
	while is_zero_approx(random_direction.x) or \
		is_zero_approx(random_direction.y):
		random_direction.x = randf_range(-1, 1)
		random_direction.y = randf_range(-1, 1)
	
	random_direction = random_direction.normalized()
	velocity = random_direction * current_speed
	
func limit_speed():
	if velocity.x > max_speed:
		velocity.x =max_speed
	if velocity.x < -max_speed:
		velocity.x =-max_speed
	if velocity.y > max_speed:
		velocity.y =max_speed
	if velocity.y < -max_speed:
		velocity.y = -max_speed	


func _on_left_goal_body_entered(body):
	reset_speed_and_position()
	Scores.player_2_score += Scores.current_ball_points
	Scores.current_ball_points =0


func _on_right_goal_body_entered(body):
	reset_speed_and_position()
	Scores.player_1_score += Scores.current_ball_points
	Scores.current_ball_points =0

func check_if_all_bricks_destroyed():
	if Scores.player_1_score + Scores.player_2_score > Scores.max_score:
		Scores.restart_text_box_contents = Scores.restart_text
