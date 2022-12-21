extends Node

class_name Plateforme

var _collided = false
## Largeur de la plateforme
var width
## Nombre de points que donne la plateforme
var points
## Joueur actif se trouvant sur la plateforme
var active_player = null


func spawn_flag()->Node2D:
	var flag = Constants.FLAG.instance()
	# Le flag est ajouté au milieu de la plateforme (offset le drapeu de 30 pour le centrer)
	flag.position = Vector2(width/2 + 30, -27)
	add_child(flag)
	return flag

## Un joueur est en collision avec la plateforme
## Retourne true si la plateforme a déjà été atteinte avant
func collide(player)->bool:
	var has_collided_before = _collided
	_collided = true
	_apply_effect(player)

	active_player = player
	return has_collided_before

## Enlève le joueur actif lorsque celui ci n'est plus en collision avec la plateforme
func uncollide():
	active_player = null

func reset_state():
	_collided = false
	active_player = null

## Applique un effet spécial au joueur
func _apply_effect(_player):
	# Les plateformes avec un effet spécial implémente cette méthode
	pass
