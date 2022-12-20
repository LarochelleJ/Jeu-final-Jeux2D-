extends KinematicBody2D

class_name Player

signal update_score(points)

export var _walk_speed = 0
export var _gravity = 1500
export var jump_height = 900

var _direction = Vector2.ZERO
var _on_floor = true
var _last_y = position.y

var _first_jump = true
var _colliding_platform = null

onready var _animated_sprite = $AnimatedSprite

func _ready():
	_walk_speed = Constants.WALK_SPEED

func _physics_process(delta):
	if GameVariables.game_is_running:
		_direction.x = 0

		read_inputs()

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

		_walk_speed = Constants.WALK_SPEED

		check_collisions()


func read_inputs():
	if Input.is_action_just_pressed("ui_accept") && _on_floor:
		if _first_jump:
			_direction.y -= 600
			_first_jump = false
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

func check_collisions():
	if _colliding_platform != null:
		if is_instance_valid(_colliding_platform):
			_colliding_platform.uncollide()

	for i in get_slide_count():
		var collision = get_slide_collision(i)

		if collision.collider.name == "Floor":
			_first_jump = true

		if collision.collider is Plateforme:
			_colliding_platform = collision.collider
			if !collision.collider.collide(self):
				emit_signal("update_score", collision.collider.points)

func change_speed(speed):
	_walk_speed = speed

func reset_position(position):
	_direction = Vector2.ZERO
	self.position = position
	_colliding_platform = null

