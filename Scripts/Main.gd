extends Node

export var Bot_number  = 5
signal call_bot

func _ready():
	
	var new_player = preload("res://Classes/player.tscn").instance()
	new_player.name = str(get_tree().get_network_unique_id())
	new_player.set_network_master(get_tree().get_network_unique_id())
	get_tree().get_root().add_child(new_player)
	var info = Network.self_data
	if get_tree().is_network_server():
		bot_setup()
	

func bot_setup():	
	self.connect("call_bot",Network,"call_bot")
	for bot in Bot_number :
		emit_signal("call_bot",bot)

	

