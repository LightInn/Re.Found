extends KinematicBody2D

export var speed = 300
export var team_id = 0

var player_attack = load("res://Classes/player_attack.tscn")
var velocity = Vector2()
var posX #position en X
var posY #position en Y
var attack
var timer 
var Is_Attacking


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	Is_Attacking = false
	timer = self.get_node("./Timer")
	timer.set_wait_time(3)
	timer.set_one_shot(true)
	
	

	pass

func _process(delta):
	
	process_inputs(delta)
	move_and_slide(velocity)
	reverse()
	
	
	if timer.get_time_left() == 0 and Is_Attacking == true:
		attack_end()
		

	
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
	attack = player_attack.instance()
	timer.set_wait_time(0.1)
	timer.start()
	Is_Attacking = true
	self.add_child(attack)

func attack_end():
	Is_Attacking = false
	attack.queue_free()
	
	

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
