extends KinematicBody2D



const gravity = 200.0
var speed = 300

var Spawn = [Vector2(50,150),Vector2(200,250),Vector2(160,550),Vector2(60,200),Vector2(250,230),Vector2(300,800),Vector2(45,1050),Vector2(1050,1000),Vector2(1800,800),Vector2(1750,450),Vector2(1850,250),Vector2(1000,100),]

slave var slave_position = Vector2()
slave var slave_velocity = Vector2(0,0)

var pause = false

var player_attack = load("res://Classes/player_attack.tscn")
var velocity = Vector2()
var posX #position en X
var posY #position en Y
var attack
var Atimer 
var PUtimer
var PU 
var Is_Attacking = false
var Is_PowerUp = false
var Is_Gravity = false
var Is_jumping = false
signal is_attacking
var node_id = self







func _ready():
	Atimer = self.get_node("./ATimer")	
	PUtimer = self.get_node("./PUTimer")	
	self.connect('is_attacking', Network ,'call_attack')
	PU = get_tree().get_root().get_node("Main").get_child(3)
	print(PU)
	
	
func _physics_process(delta):
	if pause :
		return
	if is_network_master():
		
		if Input.is_action_just_pressed("player_attack") and !Is_Attacking:
			Is_Attacking = true
			Cursor.inactive()
			Atimer.start()
			emit_signal('is_attacking',node_id)
			
			
		if Input.is_action_just_pressed("player_powerup") and Is_PowerUp:
			print("PU")
			PU.Use_PowerUp()
			Is_PowerUp = false
			PUtimer.start()
			Cursor.Swich_PowerUp()
			
		
		
		
		
		
		if !Is_Gravity:
			velocity.y = 0
			velocity.x = 0
			if Input.is_action_pressed("player_up"):
				velocity.y -= 1
			if Input.is_action_pressed("player_down"):
				velocity.y += 1
			if Input.is_action_pressed("player_left"):
				velocity.x -= 1
			elif Input.is_action_pressed("player_right"):
				velocity.x += 1
			else :
				velocity.x = 0
			
			velocity = velocity.normalized() * (delta + speed)
			move_and_slide(velocity)	
			
		else:
			if velocity.y < 200:
				velocity.y += delta * gravity
			if velocity.y > 190:
				Is_jumping = false
				
			
			var motion = velocity * delta
			move_and_collide(motion)
			
			if Input.is_action_pressed("player_left"):
				velocity.x = -speed
			elif Input.is_action_pressed("player_right"):
				velocity.x =  speed
			else:
				velocity.x = 0
			if Input.is_action_pressed("jump") and !Is_jumping:
				velocity.y = -speed
				Is_jumping = true
			move_and_slide(velocity, Vector2(0, -1))
			
		
		
		rset_unreliable('slave_position',position)
	else:
		slave_velocity =  slave_position  - self.position 
		if sqrt(slave_velocity.x*slave_velocity.x + slave_velocity.y*slave_velocity.y)<5:
			return
		elif sqrt(slave_velocity.x*slave_velocity.x + slave_velocity.y*slave_velocity.y)>300:
			self.position = slave_position 
		else:
			slave_velocity = slave_velocity.normalized() *  speed
			move_and_slide(slave_velocity)
#	if get_tree().is_network_server():
#		Network.update_position(int(name),position)
		
		

func _process(delta):
	reverse()



	



func attack():
	attack = player_attack.instance()
	Atimer.set_wait_time(0.1)
	Atimer.start()
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

func gravity_switch():
	if Is_Gravity:
		Is_Gravity = false
	
	else:
		Is_Gravity = true
	
	





func _on_PUTimer_timeout():
	print("NEWWW")
	Is_PowerUp = true
	PU.New_PowerUp()
	Cursor.Swich_PowerUp()
		


func _on_ATimer_timeout():
	Is_Attacking = false
	Cursor.activate()
	
	
