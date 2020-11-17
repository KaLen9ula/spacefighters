extends Node2D

export var fire_rate = 0.2
export var bullet_speed = 1000

onready var detection_zone = $DetectionZone
onready var bullet_point = $BulletPoint


var explosion = preload("res://Explosion.tscn")
var bullet = preload("res://EnemyFolder/EnemyBullet.tscn")
var player: Player = null
var can_fire = true
var engage = false
var actor = null

func initialize(actor):
	self.actor = actor

func _process(delta):
	if engage:
		if player != null:
			actor.rotation = actor.global_position.direction_to(player.global_position).angle()
			var bullet_instance = bullet.instance()
			bullet_instance.position = bullet_point.global_position()
			bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
			get_tree().get_root().add_child(bullet_instance)
			can_fire = false
			yield(get_tree().create_timer(fire_rate), "timeout")
			can_fire = true
			
			
			


func _on_DetectionZone_body_entered(body):
	if body.is_in_group("player"):
		player = body
		engage = true
