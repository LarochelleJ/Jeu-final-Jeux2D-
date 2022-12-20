extends KinematicBody2D

class_name Player

signal update_score(points)

export var _walk_speed = 300
export var _gravity = 1300
export var jump_height = 800

var _direction = Vector2.ZERO
var _on_floor = true
var _last_y = position.y

var first_jump = true

onready var _animated_sprite = $AnimatedSprite

func _physics_process(delta):
	_direction.x = 0

	if Input.is_action_just_pressed("ui_accept") && _on_floor:
		if first_jump:
			_direction.y -= 600
			first_jump = false
		else:
			_direction.y -= jump_height
		_on_floor = false
		_animated_sprite.play("jump")

	if Input.is_action_pressed("ui_right"):
		_direction.x += _walk_speed
		_animated_sprite.flip_h = false

	if Input.is_action_pressed("ui_left"):
		_direction.x -= _walk_speed
		_animated_sprite.flip_h = true

	if _on_floor:
		if _direction.x == 0: # Le joueur ne bouge pas
			_animated_sprite.play("idle")
		else:
			_animated_sprite.play("run")


	_direction.y += _gravity * delta

	_direction = move_and_slide(_direction, Vector2.UP)
	_on_floor = _last_y == position.y

	if !_on_floor && _last_y < position.y:
		_animated_sprite.play("fall")

	_last_y = position.y

	for i in get_slide_count():
		var collision = get_slide_collision(i)

		if collision.collider.name == "Floor":
			first_jump = true

		if collision.collider is Plateforme:
			if !collision.collider.collide():
				emit_signal("update_score", collision.collider.points)



func _process(_delta):
	pass
