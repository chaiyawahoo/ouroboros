extends Area2D

@export var damage: int = 1

func _on_body_entered(body):
	if body.has_method("take_player_damage"):
		body.take_player_damage(damage)
		# set_deferred("monitoring", false)
