extends Plateforme

const DISPLACEMENT = 150
var _move_by = DISPLACEMENT # De combien la plateforme se deplace avant de changer de direction
var _direction # 0 = gauche, 1 = droit
var _initial_position

func _init():
	width = 254
	points = 15

func _ready():
	_direction = randi() % 2
	_initial_position = self.position

func _physics_process(_delta):
	# On deplace la plateforme par itteration de 4
	self.position.x += 4 if _direction else -4
	# Si un joueur est sur la plateforme on déplace le lui aussi
	if active_player != null:
		active_player.position.x += 4 if _direction else -4

	_move_by -= 1

	# On inverse la direction lorsque la plateforme atteint le min ou le max x
	if self.position.x + width >= Constants.PLATFORM_MAX_X || self.position.x <= Constants.PLATFORM_MIN_X:
		_direction = 1 - _direction

	# On inverse la direction lorsque la plateforme a parcourue sa distance (displacement)
	if _move_by <= 0:
		_direction = 1 - _direction
		_move_by = DISPLACEMENT

# Function héritée
func _apply_effect(_player):
	_player.change_speed_temporary(Constants.WALK_SPEED * 2.0)

# Function héritée
func reset_state():
	# On appel la méthode de base
	.reset_state()
	
	_move_by = DISPLACEMENT
	_direction = randi() % 2
	self.position = _initial_position

