extends Node2D

const PLAYER_SCENE = preload("res://gnome.tscn")

func _ready() -> void:
	var player_instant = PLAYER_SCENE.instantiate()
	player_instant.position = Vector2(0, 0)
	
	add_child(player_instant)
	$hatsmith.player = player_instant
