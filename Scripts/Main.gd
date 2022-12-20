extends Node2D
var _platform_reached = 0
var _score = 0
var _number_of_platforms = 5
var _start_position = Vector2.ZERO
var _last_plateform_pos = Vector2.ZERO
var _rng = RandomNumberGenerator.new()
var _generated_platforms = []

func _process(_delta):
	for collider in get_tree().get_nodes_in_group("Limit colliders"):
		collider.position.y = $Player.position.y

func _ready():
	_last_plateform_pos = $Plateforme3.position
	_start_position = $Player.position

func _generate_platforms():
	for n in _number_of_platforms:
		var random_platform = _rng.randi_range(0, Constants.plateforms_template.size()-1)
		var platform = Constants.plateforms_template[random_platform].instance()
		var position = _last_plateform_pos.y - 200
		# Position x
		while true:
			var max_x = Constants.PLATFORM_MAX_X - platform.width
			var random_x = _rng.randi_range(Constants.PLATFORM_MIN_X, max_x)
			if validate_x_pos(random_x, platform.width):
				platform.position.x = random_x
				break

		platform.position.y = position
		_last_plateform_pos = platform.position

		if n == _number_of_platforms-1:
			var flag = platform.spawn_flag()
			flag.connect("body_entered", self, "_on_Flag_body_entered")

		_generated_platforms.append(platform)
		add_child(platform)

func validate_x_pos(x_pos, platform_width)->bool:
	return true

func _new_level():
	for platform in _generated_platforms:
		platform.queue_free()

	_generated_platforms.clear()
		
	_number_of_platforms += 2
	_platform_reached = 0
	_last_plateform_pos = $Plateforme3.position
	for platform in get_tree().get_nodes_in_group("Static Platforms"):
		platform.reset_state()

	$Player.position = _start_position

func _update_score(points):
	_score += points
	print(_score)

func _on_Player_update_score(points):
	_platform_reached += 1

	if _platform_reached == 1:
		_generate_platforms()
	
	if _platform_reached > 3:
		_update_score(points)
	

func _on_Flag_body_entered(body:Node):
	if body is Player:
		var final_platform = _generated_platforms[_generated_platforms.size()-1]
		if !final_platform.collide():
			_update_score(final_platform.points)

		_new_level()


		



