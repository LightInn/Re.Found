extends KinematicBody2D



export var speed = 300
const gravity = 200.0

var Is_Gravity = false
var Is_jumping = false
var Is_Madness = false
var Bot = true
var Spawn = [Vector2(50,150),Vector2(200,250),Vector2(160,550),Vector2(60,200),Vector2(250,230),Vector2(300,800),Vector2(45,1050),Vector2(1050,1000),Vector2(1800,800),Vector2(1750,450),Vector2(1850,250),Vector2(1000,100),]
var velocity = Vector2()
var timer
var BotPosition 

var posX #position en X
var posY #position en Y

var AxeX
var AxeY
var moveX
var moveY
puppet var slave_move = Vector2(0,0)
puppet var slave_position = Vector2(0,0)

#-----------------------------------------------------------------------

func _ready():
	timer = get_node("Timer")
	if is_network_master():
		RandomMotion()



#-----------------------------------------------------------------------

func _process(delta):
	reverse()
	if is_network_master():
		
		if Is_Madness:
			return
		
		rset_unreliable("slave_position", self.position)
		
		
		if !Is_Gravity:
			velocity = Vector2(moveX,moveY)
			velocity = velocity.normalized() * speed
			move_and_slide(velocity)
		
			
		else:
			if velocity.y < 200:
				velocity.y += delta * gravity
			if velocity.y > 150:
				Is_jumping = false
				
			velocity = Vector2(moveX,velocity.y)
			var motion = velocity * delta
			
			move_and_slide(velocity, Vector2(0, -1))
		
	else:
		
		move_and_slide(slave_move)
		self.position = slave_position
		

func _jump():
	velocity.y = -speed
	Is_jumping = true





func _on_Timer_timeout():
	if is_network_master():
		RandomMotion()
		
			

		
	
#-----------------------------------------------------------------------
func RandomMotion() :
	timer.wait_time  = rand_range(0,3)
	timer.start()
	#Random Way
	AxeX = int(rand_range(-2,2))
	AxeY = int(rand_range(-2,2))
	
	if !Is_jumping:
		_jump()
	
	moveX = speed * AxeX
	moveY = speed * AxeY

	

func Respawn():
	var index = int(rand_range(0,Spawn.size()))
	self.position =  Spawn[index] 





#-----------------------------------------------------------------------
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
	
func madness_switch():
	if Is_Madness:
		Is_Madness = false
	else:
		Is_Madness = true
