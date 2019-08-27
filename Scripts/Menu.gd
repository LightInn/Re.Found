extends Panel

onready var lobby_contain = $"./ContainerGlobal/NetworkContainer/TabContainer/Host/HBoxContainer/Lobby"
onready var host_buttons = $"./ContainerGlobal/NetworkContainer/TabContainer/Host/HBoxContainer/hosts_buttons"

signal launch_client

func _ready():
	get_tree().connect("network_peer_connected",self, "_load_game")
	self.connect("launch_client", Network,"call_client_lauch")


func _on_Host_pressed():
	Network.create_server()
	
	_load_lobby()
	#_load_game(0)




func _on_Join_pressed():
	Network.connect_to_server()
	_load_game(0)
	


func _load_lobby():
	
	lobby_contain.visible = true
	host_buttons.visible = false
	
	
	pass


func _load_game(id):
	if id == 1:
		pass
	else:
		print("STARSSS")
		get_tree().change_scene('res://Scenes/Main.tscn')
		emit_signal("launch_client")


func _on_Quit_pressed():
	get_tree().quit()



