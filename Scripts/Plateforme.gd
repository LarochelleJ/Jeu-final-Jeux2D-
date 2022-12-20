extends Node

class_name Plateforme

var _collided = false
var width
var points
var active_player = null


func spawn_flag()->Node2D:
	var flag = Constants.FLAG.instance()
	flag.position = Vector2(width/2 + 30, -27)
	add_child(flag)
	return flag

func collide(player)->bool:
	var has_collided_before = _collided
	_collided = true
	_apply_effect(player)

	active_player = player
	return has_collided_before

func uncollide():
	active_player = null

func reset_state():
	_collided = false
	active_player = null

func _apply_effect(_player):
	pass
