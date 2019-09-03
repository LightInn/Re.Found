extends Node

var PU_list = ["gravity","stop_reverse","bots_behaviour","speed"]
var PU_rand
var timer

func _ready():
	timer = $Timer


func New_PowerUp():
	$AnimationPlayer.play("PU_test")	
	PU_rand = PU_list[randi() % PU_list.size()]
	
	
func Use_PowerUp():
	rpc(PU_rand)

func _on_Timer_timeout():
	PU_rand += "_end"
	self.call(PU_rand)
	




##########      >>> PowerUp 


sync func gravity():
	print("GRAVITY")
	get_tree().call_group("entity","gravity_switch")
	timer.wait_time = 10
	timer.start()

sync func gravity_end():
	print("ENDDDDSS")
	get_tree().call_group("entity","gravity_switch")
	


sync func stop_reverse():
	pass

sync func stop_reverse_end():
	pass

sync func bots_behaviour():
	pass
	
sync func bots_behaviour_end():
	pass


sync func speed():
	pass

sync func speed_end():
	pass





