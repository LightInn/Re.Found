extends Node

export var Bot_number  = 12
signal call_bot
var ScoreUI


func _ready():
	
	var new_player = preload("res://Classes/player.tscn").instance()
	new_player.name = str(get_tree().get_network_unique_id())
	new_player.set_network_master(get_tree().get_network_unique_id())
	new_player.modulate = Color(1,0,0)
	get_tree().get_root().add_child(new_player)
	
	var info = Network.self_data
	new_player.position = info.Position
	if get_tree().is_network_server():
		bot_setup()
	
	var ScoreUI = preload("res://Classes/ScoreUI.tscn").instance()
	ScoreUI.name = "ScoreUI"
	self.add_child(ScoreUI)
	
	
	

func bot_setup():	
	self.connect("call_bot",Network,"call_bot")
	for bot in Bot_number :
		emit_signal("call_bot",bot)

func Score_change():
	self.get_node("ScoreUI").Add_Score_local()

	

