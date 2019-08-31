extends KinematicBody2D

export var speed = 300
export var team_id = 0

var Spawn = [Vector2(50,150),Vector2(200,250),Vector2(160,550),Vector2(60,200),Vector2(250,230),Vector2(300,800),Vector2(45,1050),Vector2(1050,1000),Vector2(1800,800),Vector2(1750,450),Vector2(1850,250),Vector2(1000,100),]

slave var slave_position = Vector2()
slave var slave_velocity = Vector2(0,0)


var player_attack = load("res://Classes/player_attack.tscn")
var velocity = Vector2()
var posX #position en X
var posY #position en Y
var attack
var timer 
var Is_Attacking = false
signal is_attacking
var node_id = self






func _ready():
	timer = self.get_node("./Timer")	
	self.connect('is_attacking', Network ,'call_attack')
	
	
func _physics_process(delta):
	
	if is_network_master():
		
		if Input.is_action_just_pressed("player_attack") and !Is_Attacking:
			Is_Attacking = true
			Cursor.inactive()
			timer.start()
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
		self.position = slave_position
#	if get_tree().is_network_server():
#		Network.update_position(int(name),position)
		
		

func _process(delta):
	reverse()


func _move(direction):
	move_and_slide(velocity)



func attack():
	attack = player_attack.instance()
	timer.set_wait_time(0.1)
	timer.start()
	Is_Attacking = true
	self.add_child(attack)


func Respawn():
	var index = int(rand_range(0,Spawn.size()))
	self.position =  Spawn[index] 
	#Network.respawn()



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


func _on_Timer_timeout():
	Is_Attacking = false
	Cursor.activate()
