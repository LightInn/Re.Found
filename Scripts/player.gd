extends KinematicBody2D

export var speed = 300
export var team_id = 0
var attack_sphere = load("res://Classes/player_attack.tscn")
var velocity = Vector2()
var posX #position en X
var posY #position en Y


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here

	pass

func _process(delta):
	
	process_inputs(delta)
	move_and_slide(velocity)
	reverse()
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
	velocity = velocity.normalized() * (speed + delta)
	
	if Input.is_action_just_pressed("player_attack"):
		attack()

func attack():
	var sphere = attack_sphere.instance()
	self.add_child(sphere)

func reverse():
	posX = self.get_position().x
	posY = self.get_position().y
	if posX < 0 :
		self.set_position(Vector2(get_viewport_rect().size.x , posY))
	elif posX > get_viewport_rect().size.x :
		self.set_position(Vector2( 0 , posY))
	elif posY < 0 :
		self.set_position(Vector2(posX ,get_viewport_rect().size.y ))
	elif posY > get_viewport_rect().size.y :
		self.set_position(Vector2(posX ,0))
