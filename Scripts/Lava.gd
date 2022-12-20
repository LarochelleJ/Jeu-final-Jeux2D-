extends TileMap

signal player_hit_lava

func _on_Area2D_body_entered(body:Node):
	if body is Player:
		emit_signal("player_hit_lava")
	elif !body.is_in_group("Static items"):
		body.queue_free()
