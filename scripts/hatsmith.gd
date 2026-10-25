extends CharacterBody2D

@onready var interact_radius: Area2D = $Area2D
@onready var head_marker: Marker2D = $HeadMarker
@onready var first_quest: Quest = $FirstQuest

const DIALOGUE_SCENE = preload("res://scenes/dialogue_manager.tscn")
var in_range: bool = false
var starting_text_done: bool = false
var starting_hat_given: bool = false
var dialogue_instant: Node
var player: CharacterBody2D = null
var health := 50

func _ready() -> void:
	interact_radius.body_entered.connect(_on_area_2d_body_entered)
	interact_radius.body_exited.connect(_on_area_2d_body_exited)

func _physics_process(delta: float) -> void:
	if dialogue_instant != null and dialogue_instant.is_dialogue_active == false and starting_text_done == false:
		player.change_hat(player.get_node("StarterHat"), player.current_hat)
		starting_text_done = true
		
		if first_quest.quest_status == first_quest.QuestStatus.available:
			first_quest.start_quest()
	
	
	
	if in_range and Input.is_action_just_pressed("interact"):
		if starting_text_done == false:
			initialise_dialogue(["Hey there!",
			"I am the Hatsmith, if you collect the materials, I'll make you a funky hat!",
			"What's that?",
			"You don't have a starting hat?!?!?!",
			"We can't allow that can we, here! This is your very own hat!"])
		else:
			initialise_dialogue(["screw you"])

func initialise_dialogue(dialogue: Array[String]):
	dialogue_instant = DIALOGUE_SCENE.instantiate()
	add_child(dialogue_instant)
	dialogue_instant.start_dialogue(dialogue)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		in_range = false
