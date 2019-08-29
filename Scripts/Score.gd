extends Control
var timer
var us
var other
var score


func _ready():
	timer = self.get_node("./Timer")
	us = self.get_node("./V/Own")
	other = self.get_node("./V/Enemy")

func Add_Score_local():
	if timer.get_time_left() == 0:
		timer.start()
		score = int(us.text)
		score += 1
		us.text = str(score)
		get_parent().get_node('TileMap').modulate  = Color(0.75, 1, 0.6)
		_show_score()
		rpc("_Add_Score_distant")



remote func _Add_Score_distant():
	score = int(other.text)
	score += 1
	other.text = str(score)
	get_parent().get_node('TileMap').modulate = Color(1, 0.6, 0.6)
	_show_score()


func _show_score():
	$AnimationPlayer.play("ScoreChange")
	$AudioStreamPlayer.play()

	
	
	
	
	
	
	
	
	