extends Node


func _ready():
	pass 


func _on_Button_pressed():
	self.queue_free()
	get_parent().pause = false
	get_parent().get_node(str(get_tree().get_network_unique_id())).pause = false
	


func _on_btn_Menu_pressed():
	get_tree().change_scene('res://Scenes/Menu.tscn')
