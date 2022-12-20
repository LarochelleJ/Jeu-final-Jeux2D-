extends Plateforme

const DISPLACEMENT = 150
var _move_by = DISPLACEMENT
var _direction 
var _initial_position

func _init():
	width = 254
	points = 15

func _ready():
	_direction = randi() % 2
	_initial_position = self.position

func _physics_process(_delta):
	self.position.x += 4 if _direction else -4
	if active_player != null:
		active_player.position.x += 4 if _direction else -4
	_move_by -= 1

	if self.position.x + width >= Constants.PLATFORM_MAX_X || self.position.x <= Constants.PLATFORM_MIN_X:
		_direction = 1 - _direction

	if _move_by == 0:
		_direction = 1 - _direction
		_move_by = DISPLACEMENT

func _apply_effect(_player):
	_player.change_speed(Constants.WALK_SPEED * 2.0)

func reset_state():
	.reset_state()
	_move_by = DISPLACEMENT
	_direction = randi() % 2
	self.position = _initial_position

