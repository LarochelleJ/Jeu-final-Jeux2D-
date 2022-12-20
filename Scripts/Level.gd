extends Node2D

signal update_score(points)
signal player_hit_lava

var _platform_reached = 0
var _min_platform_to_reach = Constants.MIN_PLATFORM_TO_REACH
var _number_of_platforms = 5
var _start_position = Vector2.ZERO
var _last_plateform:Plateforme = null
var _rng = RandomNumberGenerator.new()
var _generated_platforms = []

var _lava_active = false
var _lava_initial_position
var _lava_speed = 1.0

func _process(_delta):
	for collider in get_tree().get_nodes_in_group("Limit colliders"):
		collider.position.y = $Player.position.y
	
func _physics_process(_delta):
	if GameVariables.game_is_running:
		_lava()

func _ready():
	_last_plateform = $Plateforme3
	_start_position = $Player.position
	_lava_initial_position = $Lava.position

func _generate_platforms():
	if !_generated_platforms.size():
		for n in _number_of_platforms:
			var random_platform = _rng.randi_range(0, Constants.plateforms_template.size()-1)
			var platform = Constants.plateforms_template[random_platform].instance()
			var position = _last_plateform.position.y - 200
			# Position x
			while true:
				var max_x = Constants.PLATFORM_MAX_X - platform.width
				var random_x = _rng.randi_range(Constants.PLATFORM_MIN_X, max_x)
				if validate_x_pos(random_x, platform.width):
					platform.position.x = random_x
					break

			platform.position.y = position
			_last_plateform = platform

			if n == _number_of_platforms-1:
				var flag = platform.spawn_flag()
				flag.connect("body_entered", self, "_on_Flag_body_entered")

			_generated_platforms.append(platform)
			add_child(platform)

func validate_x_pos(x_pos, platform_width)->bool:
	var last_x_pos = _last_plateform.position.x
	var distance = 0
	if x_pos + platform_width < last_x_pos:
		distance = x_pos + platform_width - last_x_pos
	elif x_pos > last_x_pos + _last_plateform.width:
		distance = x_pos - last_x_pos + _last_plateform.width
	
	return abs(distance) < 250

func _lava():
	if _lava_active:
		if _platform_reached > 1:
			$Lava.position.y -= _lava_speed
		else:
			$Lava.position.y -= 1

func _reset_lava():
	_lava_active = false
	$Lava.position = _lava_initial_position


func _new_level():
	_number_of_platforms += 2
	_min_platform_to_reach = Constants.MIN_PLATFORM_TO_REACH
	_lava_speed *= 1.20
	_generate_level()

func _generate_level():
	for platform in _generated_platforms:
		if is_instance_valid(platform):
			platform.queue_free()

	_generated_platforms.clear()
		
	_platform_reached = 0
	_last_plateform = $Plateforme3

	for platform in get_tree().get_nodes_in_group("Static Platforms"):
		platform.reset_state()

	_reset_lava()
	$Player.reset_position(_start_position)

func restart_level():
	if _platform_reached > _min_platform_to_reach:
		_min_platform_to_reach = _platform_reached

	_generate_level()

func _update_score(points):
	emit_signal("update_score", points)

func _on_Player_update_score(points):
	_platform_reached += 1

	if _platform_reached == 1:
		_generate_platforms()
		_lava_active = true
	
	if _platform_reached > _min_platform_to_reach:
		_update_score(points)
	

func _on_Flag_body_entered(body:Node):
	if body is Player:
		var final_platform = _generated_platforms[_generated_platforms.size()-1]
		if !final_platform.collide(body):
			_update_score(final_platform.points)

		_new_level()


func _on_Lava_player_hit_lava():
	emit_signal("player_hit_lava")
