extends Node2D

const PLAYER_SCENE = preload("res://scenes/gnome.tscn")
var player_instant: Node

const UI_SCENE = preload("res://scenes/ui.tscn")
var ui_instant: Node

const ENEMY_SCENE = preload("res://scenes/threadbug.tscn")
var enemy_instant: Node
var current_hat_backup: Sprite2D = null

func _ready() -> void:
	player_instant = PLAYER_SCENE.instantiate()
	player_instant.position = Vector2(0, 0)
	add_child(player_instant)
	
	ui_instant = UI_SCENE.instantiate()
	add_child(ui_instant)
	
	ui.respawn.pressed.connect(_on_respawn_pressed)
	
	$hatsmith.player = player_instant
	
	enemy_instant = ENEMY_SCENE.instantiate()
	add_child(enemy_instant)
	enemy_instant.position = Vector2(randf_range(-400.0, 400.0), randf_range(-400.0, 400.0))

func _physics_process(delta: float) -> void:
	if player_instant != null and ui_instant != null:
		ui_instant.health_bar.value = player_instant.current_health

func _on_respawn_pressed():
	print(current_hat_backup)
	player_instant = PLAYER_SCENE.instantiate()
	player_instant.position = Vector2(0, 0)
	add_child(player_instant)
	if current_hat_backup != null:
		print("yo")
		remove_child(current_hat_backup)
		player_instant.add_child(current_hat_backup)
		player_instant.current_hat = current_hat_backup
	ui.death_screen.visible = false
	$hatsmith.player = player_instant
