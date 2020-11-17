extends KinematicBody2D
class_name Player


signal player_health_chanched(new_health)


export var speed = 250
export var bullet_speed = 1000
export var fire_rate = 0.2


onready var health_stat = $Health


var explosion = preload("res://Explosion.tscn")
var bullet = preload("res://PlayerFolder/Bullet.tscn")
var can_fire = true
var max_ammo: int = 50
var current_ammo: int = max_ammo


func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		current_ammo -= 1
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
		if current_ammo == 0:
			can_fire = false
			print("out of ammo")

func _physics_process(delta):
	var direction = Vector2()
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		
	move_and_slide(direction * speed)


func handle_hit():
	health_stat.health -= 20
	emit_signal("player_health_changed", health_stat.health)
	if health_stat.health <= 0:
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()
