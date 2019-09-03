extends Node

var PU_list = ["gravity","stop_reverse","bots_behaviour","speed"]
var PU_rand

func New_PowerUp():
	$AnimationPlayer.play("PU_test")	
	PU_rand = PU_list[randi() % PU_list.size()]
	
	
func Use_PowerUp():
	self.call(PU_rand)
	




##########      >>> PowerUp 


func gravity():
	print("GRAVITYYYYY")
	pass

func stop_reverse():
	pass

func bots_behaviour():
	pass

func speed():
	pass


