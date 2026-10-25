extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
@onready var go_to_hatsmith: Quest = $GoToHatsmith

const PLAYER_SCENE = preload("res://scenes/gnome.tscn")
var player_instant: Node

const UI_SCENE = preload("res://scenes/ui.tscn")
var ui_instant: Node

const THREADBUG_SCENE = preload("res://scenes/threadbug.tscn")
var threadbug_instant: Node
var current_hat_backup: Sprite2D = null
var starting_hatsmith_quest: bool = false

func _ready() -> void:
	go_to_hatsmith.start_quest()
	
	player_instant = PLAYER_SCENE.instantiate()
	player_instant.position = Vector2(0, 0)
	add_child(player_instant)
	
	ui_instant = UI_SCENE.instantiate()
	add_child(ui_instant)
	
	ui.respawn.pressed.connect(_on_respawn_pressed)
	
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	
	$hatsmith.player = player_instant

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("interact") || starting_hatsmith_quest == true:
		go_to_hatsmith.finish_quest()
	if player_instant != null and ui_instant != null:
		ui_instant.health_bar.value = player_instant.current_health

func _on_spawn_timer_timeout() -> void:
	var alive_threadbugs = get_tree().get_nodes_in_group("threadbugs").size()
	
	if alive_threadbugs < 5:
		spawn_random_enemy()

func spawn_random_enemy() -> void:
	var threadbug_new = THREADBUG_SCENE.instantiate()
	
	while true:
		var spawn_pos = Vector2.ZERO
		
		var rand_x = randf_range(-1000.0, 1000.0)
		var rand_y = randf_range(-1000.0, 1000.0)
		spawn_pos = Vector2(rand_x, rand_y)
		
		if rand_x < -200.0 or rand_x > 200.0 or rand_y < -200.0 or rand_y > 200.0:
			break
	
	add_child(threadbug_new)
	threadbug_new.position = Vector2(randf_range(-1000.0, 1000.0), randf_range(-1000.0, 1000.0))
	threadbug_new.add_to_group("threadbugs")

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
