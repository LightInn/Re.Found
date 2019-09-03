extends Node

var PU_list = ["gravity","stop_reverse","bots_behaviour","speed"]
var PU_rand
var timer
var id

func _ready():
	timer = $Timer
	id = str(get_tree().get_network_unique_id())


func New_PowerUp():
	PU_rand = PU_list[randi() % PU_list.size()]
	$V/VBoxContainer/TextureRect.texture = load("res://Ressources/UI/powerup/" + PU_rand + ".png")
	$AnimationPlayer.play("PU_show")	
	
	
	
func Use_PowerUp():	
	rpc(PU_rand,id)

func _on_Timer_timeout():
	PU_rand += "_end"
	self.call(PU_rand,id)
	




##########      >>> PowerUp 


sync func gravity(id):
	print("GRAVITY")
	get_tree().call_group("entity","gravity_switch")
	timer.wait_time = 10
	timer.start()

sync func gravity_end(id):
	print("ENDDDDSS")
	get_tree().call_group("entity","gravity_switch")
	


sync func stop_reverse():
	get_tree().call_group("entity","reverse_switch")
	
sync func stop_reverse_end():
	pass

sync func bots_behaviour():
	get_tree().call_group("entity","madness_switch")
	timer.wait_time = 12
	timer.start()
sync func bots_behaviour_end():
	get_tree().call_group("entity","madness_switch")


sync func speed(id):
	print("SPEED// ID :  ", id)
	get_parent().get_node(id).speed = 800
	timer.wait_time = 12
	timer.start()

sync func speed_end(id):
	get_parent().get_node(str(id)).speed = 300





