class_name Enemy extends CharacterBody2D

@onready var attack_area: Area2D = $AttackArea
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: Area2D = $DetectionArea
@onready var health_bar: ProgressBar = $HealthBar

const SPEED = 150.0
var player: CharacterBody2D = null
var in_attack: bool = false
var in_detect: bool = false
var direction: Vector2
var current_health := 50
var is_dead: bool = false

func _ready() -> void:
	attack_area.body_entered.connect(_on_attack_area_body_entered)
	attack_area.body_exited.connect(_on_attack_area_body_exited)
	
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	detection_area.body_exited.connect(_on_detection_area_body_exited)
	
	animated_sprite.animation_finished.connect(_on_animation_finished)
	
func _physics_process(delta: float) -> void:
	if current_health <= 0 and not is_dead:
		is_dead = true
		ui.string_collected += 1
		queue_free()
	
	health_bar.value = current_health
	
	if in_detect == true and player != null:
		direction = (player.global_position - global_position).normalized()
	else:
		direction = Vector2.ZERO
	velocity = direction * SPEED
	
	move_and_slide()

func _on_animation_finished():
	if animated_sprite.animation == "attack":
		animated_sprite.play("default")

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Player:
		in_attack = true
		await get_tree().create_timer(1).timeout
		while in_attack == true:
			animated_sprite.play("attack")
			await get_tree().create_timer(0.2).timeout
			if is_instance_valid(body):
				body.current_health -= 10

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body is Player:
		in_attack = false

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		in_detect = true
		player = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Player:
		in_detect = false
