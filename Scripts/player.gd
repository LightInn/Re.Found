extends KinematicBody2D

export var speed = 300
export var team_id = 0



slave var slave_position = Vector2()
slave var slave_velocity = Vector2(0,0)


var player_attack = load("res://Classes/player_attack.tscn")
var velocity = Vector2()
var posX #position en X
var posY #position en Y
var attack
var timer 
var Is_Attacking
signal is_attacking
var node_id = self

func init():
	
	
	pass



func _ready():
	Is_Attacking = false
	timer = self.get_node("./Timer")
	timer.set_wait_time(3)
	timer.set_one_shot(true)
	
	self.connect('is_attacking', Network ,'call_attack')
	
	
func _physics_process(delta):
	
	if is_network_master():
		
		if Input.is_action_just_pressed("player_attack"):
			emit_signal('is_attacking',node_id)
		
		
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
			
		velocity = velocity.normalized() * (delta + speed)
		
		
		rset_unreliable('slave_position',position)
		rset('slave_velocity',velocity)
		_move(velocity)
	else:
		_move(slave_velocity)
		position = slave_position
#	if get_tree().is_network_server():
#		Network.update_position(int(name),position)
		
		

func _process(delta):
	reverse()
	
	
	
	if timer.get_time_left() == 0 and Is_Attacking == true:
		attack_end()
		

func _move(direction):
	move_and_slide(velocity)



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
	print(posX,":",posY)
	if posX < 0 :
		self.set_position(Vector2(get_viewport_rect().size.x , posY))
	elif posX > get_viewport_rect().size.x :
		self.set_position(Vector2( 0 , posY))
	elif posY < 0 :
		self.set_position(Vector2(posX ,get_viewport_rect().size.y ))
	elif posY > get_viewport_rect().size.y :
		self.set_position(Vector2(posX ,0))
