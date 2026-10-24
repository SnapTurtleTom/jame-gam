extends CharacterBody2D

@onready var interact_radius: Area2D = $Area2D

const DIALOGUE_SCENE = preload("res://dialogue_manager.tscn")
var in_range: bool = false

func _ready() -> void:
	interact_radius.body_entered.connect(_on_area_2d_body_entered)
	interact_radius.body_exited.connect(_on_area_2d_body_exited)

func _physics_process(delta: float) -> void:
	if in_range and Input.is_action_just_pressed("interact"):
		var dialogue_instant = DIALOGUE_SCENE.instantiate()
		add_child(dialogue_instant)
		dialogue_instant.start_dialogue(["Yo wassup", "It's been a while"] as Array[String])

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		in_range = false
