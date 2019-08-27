extends KinematicBody2D



export var SPEED = 200

var Bot = true

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
	
	pass

#-----------------------------------------------------------------------

func _process(delta):
	reverse()
	if is_network_master():
		velocity = Vector2(moveX,moveY)
		velocity = velocity.normalized() * SPEED
		rset("slave_move", velocity)
		move_and_slide(velocity)
		
	else:
		
		move_and_slide(slave_move)
		

func _on_Timer_timeout():
	if is_network_master():
		RandomMotion()
		rset_unreliable("slave_position", self.position)
	else:
		timer.wait_time  = 1
		timer.start()
		self.position = slave_position
			

		
	
#-----------------------------------------------------------------------
func RandomMotion() :
	timer.wait_time  = int(rand_range(1,3))
	timer.start()
	#Random Way
	AxeX = int(rand_range(-2,2))
	AxeY = int(rand_range(-2,2))
	
	moveX = SPEED * AxeX
	moveY = SPEED * AxeY
	
	



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


