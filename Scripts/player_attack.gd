extends RayCast2D

var beam_end = Vector2(0,0)

var line 
var target
var ray_result 

puppet var slave_beam_end = Vector2(0,0)

func _ready():
	line = self.get_node("./Line2D")



# warning-ignore:unused_argument
func _process(delta):
	line.set_point_position(0.1,beam_end)




# warning-ignore:unused_argument
func _physics_process(delta):
	if is_network_master():
		ray_result = get_world_2d().direct_space_state.intersect_ray(self.get_parent().position,get_global_mouse_position() ,[self.get_parent()])
		if ray_result:
			beam_end=  ray_result.position  - global_position
			target = ray_result.collider
			if target.get("Bot"):
				target.queue_free()
		else :
			beam_end= get_global_mouse_position() - global_position
			
		rset_unreliable('slave_beam_end',beam_end)
	else : 	
		beam_end =  slave_beam_end

func _on_Timer_timeout():
	self.queue_free()

