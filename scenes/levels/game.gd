extends Node2D

@onready var player = %Player
@onready var enemy = %Enemy
@onready var enemy2 = %Enemy2
func _ready():
	# Initialize nodes
	enemy.update_target_node(player)
	enemy2.update_target_node(player)
