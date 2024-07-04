class_name Player
extends CharacterBody2D


var speed := 60
var attacking_speed_mod := 0.5
var health := 3
var is_dead := false
var is_attacking := false

var move_input: Vector2
var look_input: Vector2
var is_looking_left := false
var input_zero_threshold := 0.01

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _input(event: InputEvent) -> void:
	move_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if abs(move_input.x) >= input_zero_threshold:
		is_looking_left = move_input.x < 0
	if Input.is_action_just_pressed("ui_cancel"):
		health -= 1
	if Input.is_action_pressed("attack"):
		_play_attack_animation()


func _process(delta: float) -> void:
	if is_dead or is_attacking:
		return
	
	_check_flip_sprite()
	
	if move_input.length() > 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
	
	if health <= 0:
		is_dead = true
		sprite.play("death")
		return


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	velocity = move_input * speed
	
	if is_attacking:
		velocity *= attacking_speed_mod
	
	move_and_slide()


func _track_attack_animation_finished() -> void:
	await sprite.animation_finished
	if Input.is_action_pressed("attack"):
		_play_attack_animation()
		return
	is_attacking = false


func _play_attack_animation() -> void:
	is_attacking = true
	_check_flip_sprite()
	sprite.play("attack")
	_track_attack_animation_finished()


func _check_flip_sprite() -> void:
	if is_looking_left:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
