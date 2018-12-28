extends KinematicBody2D



export var SPEED = 200

var velocity = Vector2()
var timer
var BotPosition 

var posX #position en X
var posY #position en Y

var AxeX
var AxeY
var moveX
var moveY

#-----------------------------------------------------------------------

func _ready():
	print("READY")
	timer = get_node("Timer")
	RandomMotion()
	
	pass

#-----------------------------------------------------------------------

func _process(delta):
	reverse()
	
	velocity.x = moveX
	velocity.y = moveY
	
	velocity = velocity.normalized() * SPEED
	
	move_and_slide(velocity)
	print("move and slide")
	
	if timer.time_left <= 1:
		timer.stop()
		print("<= 1")
		RandomMotion()

#-----------------------------------------------------------------------
func RandomMotion() :
	print("REACTUALISATION")
	
	
	#Timer Setup
	timer.wait_time  = int(rand_range(1,3))
	print("wait time : ", timer.wait_time)
	timer.start()
	
	
	
	
	
	#Random Way
	AxeX = int(rand_range(-2,2))
	AxeY = int(rand_range(-2,2))
	
	moveX = SPEED * AxeX
	moveY = SPEED * AxeY
	
	print("Axe X : ", moveX , "   Axe Y : " , moveY )
	
	
	
	
	BotPosition = self.get_position()


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