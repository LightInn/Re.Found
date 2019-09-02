extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 4242
const MAX_PLAYER = 5

var players = {}
var self_data = {Position = Vector2() }
var peer = NetworkedMultiplayerENet.new()
signal launch_game
var Spawn = [Vector2(50,150),Vector2(200,250),Vector2(160,550),Vector2(60,200),Vector2(250,230),Vector2(300,800),Vector2(45,1050),Vector2(1050,1000),Vector2(1800,800),Vector2(1750,450),Vector2(1850,250),Vector2(1000,100),]
puppet var s_index


func _ready():
	#get_tree().connect('network_peer_disconnected', self,'_player_disconnect')
	
	
	pass
	
	
func create_server(port):
	_data_maker()
	#self_data.Position = spawn[2]
	players[1] = self_data
	peer.create_server(port, MAX_PLAYER)
	get_tree().set_network_peer(peer)
	print("server crre",port)
	
	
	
func connect_to_server(ip,port):
# warning-ignore:return_value_discarded
	print("start",ip,port)
	_data_maker()
	print("data maker",ip,port)
	#self_data.Position = spawn[3]
	
	peer.create_client(ip, port)
	print("create clien",ip,port)
	get_tree().set_network_peer(peer)
	print("set per",ip,port)
	
	
	
	
	
func call_client_lauch():
	rpc('_client_launch')
remote func _client_launch():
	
	players[get_tree().get_network_unique_id()] = self_data
	rpc('_send_player_info', get_tree().get_network_unique_id(), self_data)
	emit_signal("launch_game")
	
	
func _data_maker():
	var index = int(rand_range(0,Spawn.size()))
	
	self_data.Position = Spawn[index] 
	Spawn.remove(index)
	print(Spawn)

	
remote func _send_player_info(id, data):
		if get_tree().is_network_server():
			for peer_id in players:
				rpc_id(id, '_send_player_info', peer_id, players[peer_id])
		players[id] = data
		
		var new_player = load('res://Classes/player.tscn').instance()
		new_player.name = str(id)
		new_player.set_network_master(id)
		get_tree().get_root().get_node('Main').add_child(new_player)
		new_player.visible = true
		#new_player.position = data.Position


###########       Attack

func call_attack(node_id):
	rpc('_player_attack',node_id,get_tree().get_network_unique_id())
sync func _player_attack(node_id,id):
	print(node_id)
	var new_attack = load("res://Classes/player_attack.tscn").instance()
	new_attack.name = str(id) + "_attack"
	new_attack.set_network_master(id)
	var owner = get_tree().get_root().get_node('Main').get_node(str(id))
	owner.add_child(new_attack)	
	#new_attack.init(id)
	


	
	
	
############         Bots

func call_bot(number):
	var index = int(rand_range(0,Spawn.size()))
	rpc("_setup_bots",number,Spawn[index])
	#Spawn.remove(index)
	
	
	
	
sync func _setup_bots(number,Spawn):
	var bot = load("res://Classes/Bot.tscn").instance()
	bot.name = "bot_" + str(number)
	bot.set_network_master(1)
	get_tree().get_root().get_node('Main').add_child(bot)	
	bot.position = Spawn
	print(Spawn)
	
	




