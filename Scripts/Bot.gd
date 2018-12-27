extends KinematicBody2D



var path = []
var speed = 1
var transition = 0
var path_points = 0
var timer
var SetRandomtime
var RandomPoint
var BotPosition 


func _ready():
	timer = get_node("Timer")
	timer.start()
	pass

func _process(delta):
	
	
	
	if timer.time_left == 0:
		print("time end !!!!")
		timer.stop()
		RandomMotion()
	path = get_node("../Map_default/Navigation2D").get_simple_path(BotPosition, RandomPoint)
	update()

func _draw():
    for p in path:
        draw_circle(p, 10, Color(1, 1, 1))
		

		
func RandomMotion() :
	timer.wait_time  = int(rand_range(3,50))
	print(timer.wait_time)
	timer.start()
	BotPosition = self.get_position()
	RandomPoint = Vector2(rand_range(0,get_viewport_rect().size.x),rand_range(0,get_viewport_rect().size.y))
	
	