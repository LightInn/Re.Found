extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 4242
const MAX_PLAYER = 5

var players = {}
var self_data = {Position = Vector2() }
var peer = NetworkedMultiplayerENet.new()
signal launch_game
var spawn = [Vector2(50,150),Vector2(200,250),Vector2(160,550),Vector2(300,800),Vector2(45,1050),Vector2(1050,1000),Vector2(1800,800),Vector2(1750,450),Vector2(1850,250),Vector2(1000,100),]
puppet var s_index


func _ready():
	#get_tree().connect('network_peer_disconnected', self,'_player_disconnect')
	
	
	pass
	
	
func create_server():
	_data_maker()
	players[1] = self_data
	peer.create_server(DEFAULT_PORT, MAX_PLAYER)
	get_tree().set_network_peer(peer)
	
	
	
func connect_to_server():
# warning-ignore:return_value_discarded
	get_tree().connect("connected_to_server", self,"_connected_to_server")
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)
	
	
func _connected_to_server():
	_data_maker()
	players[get_tree().get_network_unique_id()] = self_data
	rpc('_send_player_info', get_tree().get_network_unique_id(), self_data)
	emit_signal("launch_game")
	
	
func _data_maker():
	var index = int(rand_range(0,spawn.size()))
	self_data.Position = spawn[index] 
	spawn.remove(index)

	
remote func _send_player_info(id, data):
		if get_tree().is_network_server():
			for peer_id in players:
				rpc_id(id, '_send_player_info', peer_id, players[peer_id])
		players[id] = data
		
		var new_player = load('res://Classes/player.tscn').instance()
		new_player.name = str(id)
		new_player.set_network_master(id)
		get_tree().get_root().add_child(new_player)
		new_player.position = data.Position


###########       Attack

func call_attack(node_id):
	rpc('_player_attack',node_id,get_tree().get_network_unique_id())
sync func _player_attack(node_id,id):
	print(node_id)
	var new_attack = load("res://Classes/player_attack.tscn").instance()
	new_attack.name = str(id) + "_attack"
	new_attack.set_network_master(id)
	var owner = get_tree().get_root().get_node(str(id))
	owner.add_child(new_attack)	
	#new_attack.init(id)
	
############         Bots

func call_bot(number):
	var index = int(rand_range(0,spawn.size()))
	rpc("_setup_bots",number,spawn[index])
	spawn.remove(index)
	
	
	
	
sync func _setup_bots(number,Spawn):
	var bot = load("res://Classes/Bot.tscn").instance()
	bot.name = "bot_" + str(number)
	bot.set_network_master(1)
	get_tree().get_root().add_child(bot)	
	bot.position = Spawn
	
	




