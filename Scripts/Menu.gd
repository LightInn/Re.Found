extends Panel



func _on_Host_pressed():
	Network.create_server()
	_load_game()


func _on_Join_pressed():
	Network.connect_to_server()
	_load_game()
	


func _load_game():
	get_tree().change_scene('res://Scenes/main.tscn')
	print("loading game")


func _on_Quit_pressed():
	get_tree().quit()



