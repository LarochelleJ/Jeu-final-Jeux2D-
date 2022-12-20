extends Node

class_name Plateforme

var _collided = false
var width
var points


func spawn_flag()->Node2D:
	var flag = Constants.FLAG.instance()
	flag.position = Vector2(width/2 + 30, -27)
	add_child(flag)
	return flag

func collide()->bool:
	var has_collided_before = _collided
	_collided = true
	return has_collided_before

func reset_state():
	_collided = false
