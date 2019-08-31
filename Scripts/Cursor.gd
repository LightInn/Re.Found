extends Node

var target
var velocity
var us 
var magn



func _process(delta):
	
	
	target = get_viewport().get_mouse_position()
	us = $Sprite.position
	velocity =  target - us
	
	magn = sqrt(velocity.x*velocity.x + velocity.y*velocity.y)
	velocity = velocity.normalized() * delta *magn * 10
	$Sprite.position += velocity
	
func inactive():
	$Sprite.texture = load("res://Ressources/cursor_inactive.png")
	
func activate():
	$Sprite.texture = load("res://Ressources/cursor_active.png")
	