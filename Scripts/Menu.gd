extends Node2D

func _on_Start_pressed():
	GameVariables.game_is_running = true
	queue_free()

func _on_Quit_pressed():
	get_tree().quit()
