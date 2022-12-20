extends Node2D

var _score = 0
var _hp = 3

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_Level_update_score(points):
	_update_score(points)

func _update_score(points):
	_score += points
	$CanvasLayer/Score.text = str(_score)


func _on_Level_player_hit_lava():
	yield(get_tree().create_timer(0.2), "timeout")
	_hp -= 1
	$CanvasLayer/HP.frame = _hp
	$Level.restart_level()
	
	if !_hp:
		GameVariables.game_is_running = false
		if get_tree().change_scene(Constants.MAIN_SCENE):
			print("Une erreur s'est produite lors du rechargement du jeu.")
