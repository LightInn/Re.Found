extends Panel
var port_Node
var maxplayer_Node



func _ready():
	

	pass
	
	
func _on_Host_pressed():
	print("HOST")
	var  SERVER_PORT = 4242
	var  MAX_PLAYERS = 8

	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	get_tree().get_network_peer()
	pass 




func _on_Join_pressed():
	pass # Replace with function body.



func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.




