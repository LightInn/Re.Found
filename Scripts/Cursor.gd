extends Node

var target
var velocity
var us 
var magn
var Is_PUvisible = false



func _process(delta):
	
	
	target = get_viewport().get_mouse_position()
	us = $Pos.position
	velocity =  target - us
	
	magn = sqrt(velocity.x*velocity.x + velocity.y*velocity.y)
	velocity = velocity.normalized() * delta *magn * 10
	$Pos.position += velocity
	
func inactive():
	$Pos/Sprite.texture = load("res://Ressources/UI/cursor/cursor_inactive.png")
	
func activate():
	$Pos/Sprite.texture = load("res://Ressources/UI/cursor/cursor_active.png")
func Swich_PowerUp():
	print("swxit")
	if Is_PUvisible :
		$Pos/PUSprite.visible = false
		Is_PUvisible = false
		
	else : 
		$Pos/PUSprite.visible = true
		Is_PUvisible = true
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
