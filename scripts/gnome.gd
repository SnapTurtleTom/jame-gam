extends CharacterBody2D
class_name Player

@export var speed: float = 400
@onready var animated_sprite = $AnimatedSprite2D
@onready var knife: Area2D = $Knife
@onready var knife_collision: CollisionShape2D = $Knife/CollisionShape2D

var input_direction:= Vector2.ZERO
var last_direction:= Vector2.ZERO
var current_hat: Sprite2D = null
var current_health = 500
var parent: Node
var mouse_dir = get_global_mouse_position() - global_position
var angle = mouse_dir.angle()
var is_attacking: bool = false
var cooldown_on: bool = false

func _ready():
	knife.body_entered.connect(_on_knife_body_entered)
	parent = self.get_parent()
	
	animated_sprite.play("forward-idle")
	
	for child in get_children():
		if child is Sprite2D:
			child.hide()
	
	knife_collision.disabled = true

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction.length() > 0.05:
		last_direction = input_direction

func _physics_process(delta):
	if current_health <= 0:
		parent.current_hat_backup = current_hat
		remove_child(parent.current_hat_backup)
		parent.add_child(parent.current_hat_backup)
		queue_free()
		ui.death_screen.visible = true
	
	get_input()
	if input_direction.length() <= 0.05:
		idle_animation(last_direction)
	else:
		movement_animation(input_direction)
	
	mouse_dir = get_global_mouse_position() - global_position
	angle = mouse_dir.angle()
	attack()
	
	velocity = input_direction * speed
	
	move_and_slide()

func attack():
	if Input.is_action_just_pressed("attack") and cooldown_on == false:
		cooldown_on = true
		is_attacking = true
		knife.rotation = angle
		knife.rotation -= deg_to_rad(90)
		knife.visible = true
		knife_collision.disabled = false
		await get_tree().create_timer(0.5).timeout
		cooldown_on = false
		is_attacking = false
	elif is_attacking == false:
		knife.visible = false
		knife_collision.disabled = true

func _on_knife_body_entered(body: Node2D):
	if body is Enemy:
		body.current_health -= 10

func idle_animation(input_direction: Vector2):
	if input_direction.y > 0:
		animated_sprite.play("forward-idle")
	elif input_direction.y < 0:
		animated_sprite.play("backwards-idle")
	elif input_direction.x > 0:
		animated_sprite.play("right-idle")
	elif input_direction.x < 0:
		animated_sprite.play("left-idle")

func movement_animation(input_direction: Vector2):
	if input_direction.y > 0:
		animated_sprite.play("forward-walk")
	elif input_direction.y < 0:
		animated_sprite.play("backwards-walk")
	elif input_direction.x > 0:
		animated_sprite.play("right-walk")
	elif input_direction.x < 0:
		animated_sprite.play("left-walk")

func change_hat(new_hat, old_hat: Sprite2D):
	if old_hat != null:
		old_hat.hide()
	
	old_hat = new_hat
	old_hat.visible = true
	current_hat = new_hat
