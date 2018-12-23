extends KinematicBody2D

export var speed = 300
export var attack_radius = 100

var velocity = Vector2()


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	process_inputs(delta)
	move_and_slide(velocity)
	pass

func process_inputs(delta):
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("player_up"):
		velocity.y -= 1
	if Input.is_action_pressed("player_down"):
		velocity.y += 1
	if Input.is_action_pressed("player_left"):
		velocity.x -= 1
	if Input.is_action_pressed("player_right"):
		velocity.x += 1
	velocity = velocity.normalized() * speed
	
	if Input.is_action_pressed("player_attack"):
		attack()

func attack():
	pass