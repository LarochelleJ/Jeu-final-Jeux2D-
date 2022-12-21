extends KinematicBody2D

class_name Player

signal update_score(points)

export var walk_speed = 0 setget change_speed
export(int, 0, 3000) var gravity = 1500
export var jump_height = 900

var _direction = Vector2.ZERO
var _last_y = position.y

var _first_jump = true
var _colliding_platform = null

onready var _animated_sprite = $AnimatedSprite

func _ready():
	walk_speed = Constants.WALK_SPEED

func _physics_process(delta):
	if GameVariables.game_is_running:
		_direction.x = 0

		read_inputs()

		# On applique la gravité
		_direction.y += gravity * delta 

		_direction = move_and_slide(_direction, Vector2.UP)

		if is_on_floor():
			if _direction.x == 0: # Le joueur ne bouge pas
				_animated_sprite.play("idle")
			else:
				_animated_sprite.play("run")

		# Chute lbre
		if _last_y < position.y:
			_animated_sprite.play("fall")

		_last_y = position.y

		walk_speed = Constants.WALK_SPEED

		check_collisions()


func read_inputs():
	# On peut sauter seulement si le joueur est au sol
	if Input.is_action_just_pressed("ui_accept") && is_on_floor():
		# Au premier saut, on réduit la hauteur puisque la première plateforme est
		# plus proche du sol
		if _first_jump:
			_direction.y -= 600
			_first_jump = false
		else:
			_direction.y -= jump_height
		_animated_sprite.play("jump")

	if Input.is_action_pressed("ui_right"):
		_direction.x += walk_speed
		_animated_sprite.flip_h = false

	if Input.is_action_pressed("ui_left"):
		_direction.x -= walk_speed
		_animated_sprite.flip_h = true

func check_collisions():
	# On enlève le joueur actif de la plateforme que le joueur était en collision avec
	if _colliding_platform != null:
		if is_instance_valid(_colliding_platform):
			_colliding_platform.uncollide()

	for i in get_slide_count():
		var collision = get_slide_collision(i)

		# Si le joueur est au sol, son prochain saut sera alors le premier
		if collision.collider.name == "Floor":
			_first_jump = true

		if collision.collider is Plateforme:
			_colliding_platform = collision.collider
			# Si la plateforme n'as pas déjà été atteinte, on ajoute les points
			if !collision.collider.collide(self):
				emit_signal("update_score", collision.collider.points)

func change_speed(speed):
	if speed == 0:
		Constants.WALK_SPEED = 300
	else:
		Constants.WALK_SPEED = speed

	walk_speed = Constants.WALK_SPEED

## Change temporairement la vitesse du joueur
func change_speed_temporary(speed):
	walk_speed = speed

## Remettre à zéro la position du joueur
func reset_position(position):
	_direction = Vector2.ZERO
	self.position = position
	_colliding_platform = null

