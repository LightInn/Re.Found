extends Node2D

var beam_end
var line 
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	line = self.get_node("./Line2D")
	pass

func _process(delta):
	line.set_point_position(0,Vector2(0,0))
	line.set_point_position(1,beam_end)
	
	if Input.is_mouse_button_pressed(1):
		print("local mouse : ")
		print(get_local_mouse_position())
		print("beam_end : ") 
		print(beam_end)

func _physics_process(delta):
	var ray_result = get_world_2d().direct_space_state.intersect_ray(self.global_position,get_global_mouse_position(),[self.get_parent()])
	#													Ray cast 		start position		end position				do not collide with the player
	if ray_result:
		beam_end= ( ray_result.position - global_position ) *2
	else :
		
		beam_end= ( get_global_mouse_position() - global_position ) *2 
