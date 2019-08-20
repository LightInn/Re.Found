extends Node2D

var beam_end
var line 
var target

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	line = self.get_node("./Line2D")
	

	
	pass

func _process(delta):
	
	line.set_point_position(0.2,beam_end)
	
		
	
	
	

func _physics_process(delta):
	var ray_result = get_world_2d().direct_space_state.intersect_ray(self.global_position,get_global_mouse_position(),[self.get_parent()])
	#													Ray cast 		start position		end position				do not collide with the player
	if ray_result:
		beam_end= ( ray_result.position - global_position ) 
		target = ray_result.collider
		
		if target.get("Bot"):
			target.queue_free()
	else :
		
		beam_end= ( get_global_mouse_position() - global_position )
