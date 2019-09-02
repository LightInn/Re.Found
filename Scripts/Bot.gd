extends KinematicBody2D



export var SPEED = 300

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
		velocity = Vector2(moveX,moveY)
		velocity = velocity.normalized() * SPEED
		move_and_slide(velocity)
		rset_unreliable("slave_position", self.position)
		
	else:
		
		move_and_slide(slave_move)
		self.position = slave_position
		

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
	
	moveX = SPEED * AxeX
	moveY = SPEED * AxeY
	
	

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


