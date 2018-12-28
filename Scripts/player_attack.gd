extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var growing_speed = .3
export var start_size = 0
var timer

var shooter

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	timer = get_node("Timer")
	self.scale.x = start_size
	self.scale.y = start_size
	

func _process(delta):
	if timer.time_left == 0:
		queue_free()
	self.scale.x += growing_speed
	self.scale.y += growing_speed

func get_shooter():
	return shooter
	
func set_shooter(s):
	shooter = s