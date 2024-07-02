class_name Enemy
extends CharacterBody2D

var speed := 0.25
var health := 3
var damage := 1
var is_dead := false
var player: Player

func _physics_process(_delta):
	if player is Player:
		var target = Vector2(player.position.x - position.x, player.position.y - position.y)
		
		velocity = target * speed
		move_and_slide()
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider is Player:
				collider.take_damage(damage)

func update_target_node(_player: Player):
	if _player is Player:
		player = _player

func take_player_damage(incoming_damage: int):
	health -= incoming_damage
	print("enemy health ", health)
