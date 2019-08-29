extends Node


func _ready():
	pass 


func _on_Button_pressed():
	self.queue_free()
	get_parent().pause = false


func _on_btn_Menu_pressed():
	get_tree().change_scene('res://Scenes/Menu.tscn')
