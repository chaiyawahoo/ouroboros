class_name Player
extends CharacterBody2D


var speed := 80
var health := 3
var is_dead := false
var is_attacking := false
var damage := 1
var move_input: Vector2

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _input(_event: InputEvent) -> void:
	move_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if Input.is_action_just_pressed("ui_cancel"):
		health -= 1
	if Input.is_action_pressed("attack"):
		is_attacking = true
		sprite.play("attack")
		track_attack_animation_finished()


func _process(_delta: float) -> void:
	if is_dead or is_attacking:
		return
	
	if move_input.x < 0:
		sprite.flip_h = true
	elif move_input.x > 0:
		sprite.flip_h = false
	
	if move_input.length() > 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
	
	if health <= 0:
		health = 0
		is_dead = true
		sprite.play("death")


func _physics_process(_delta: float) -> void:
	if is_dead or is_attacking:
		return 
	velocity = move_input * speed
	move_and_slide()


func track_attack_animation_finished() -> void:
	$Weapon.monitoring = true
	await sprite.animation_finished
	if Input.is_action_pressed("attack"):
		sprite.play("attack")
		$Weapon.monitoring = false
		track_attack_animation_finished()
		return
	is_attacking = false
	$Weapon.monitoring = false

func take_damage(incoming_damage: int):
	# if health > 0:
	# 	health -= incoming_damage
	# print(health)
	pass
