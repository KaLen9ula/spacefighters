extends KinematicBody2D

export var speed = 250
export var bullet_speed = 1000
export var fire_rate = 0.7

var explosion = preload("res://Explosion.tscn")
var bullet = preload("res://EnemyFolder/EnemyBullet.tscn")
var health = 100
var player: Player = null
var can_fire = true
var engage = true

func _process(delta):
	if engage:
		if player != null:
			rotation = global_position.direction_to(player.global_position).angle()

func handle_hit():
	health -= 20
	if health <= 0:
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()


func _on_DetectionZone_body_entered(body):
	if body.is_in_group("player"):
		player = body
