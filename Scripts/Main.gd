extends Node

export var Bot_number  = 8
signal call_bot
var ScoreUI
var pause = false



func _ready():
	
		################      >> UI
	var ScoreUI = preload("res://Classes/ScoreUI.tscn").instance()
	ScoreUI.name = "ScoreUI"
	self.add_child(ScoreUI)
	var PuUI = preload("res://Classes/PowerupUI.tscn").instance()
	PuUI.name = "PuUI"
	self.add_child(PuUI)
	
		################      >> BOTS + PLAYER
	
	
	var new_player = preload("res://Classes/player.tscn").instance()
	new_player.name = str(get_tree().get_network_unique_id())
	new_player.set_network_master(get_tree().get_network_unique_id())
	
	self.add_child(new_player)
	
	new_player.get_node("Sprite").texture = load("res://Ressources/textures/entity/Player.png")
	
	var info = Network.self_data
	new_player.position = info.Position
	if get_tree().is_network_server():
		bot_setup()
	
	

	
	
	

func bot_setup():	
	self.connect("call_bot",Network,"call_bot")
	for bot in Bot_number :
		emit_signal("call_bot",bot)

func Score_change():
	self.get_node("ScoreUI").Add_Score_local()
	if is_network_master():
		get_tree().call_group("bots","Respawn")
		get_tree().call_group("players","Respawn")
		
	else:
		rpc("_call_respawn")
		
remote func 	_call_respawn():
	get_tree().call_group("bots","Respawn")
	get_tree().call_group("players","Respawn")
	


	
func _process(delta):
	var PauseMenu = preload("res://Classes/PauseMenu.tscn").instance()
	if Input.is_action_pressed("ui_cancel") and pause == false:
		self.add_child(PauseMenu)
		PauseMenu.set_as_toplevel(false)
		
		pause = true
		self.get_node(str(get_tree().get_network_unique_id())).pause  = true
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
