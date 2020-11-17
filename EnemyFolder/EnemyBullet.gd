extends RigidBody2D

var explosion = preload("res://Explosion.tscn")

func _on_EnemyBullet_body_entered(body):
	if body.has_method("handle_hit"):
		if body.is_in_group("bounds"):
			queue_free()
		else:
			var explosion_instance = explosion.instance()
			explosion_instance.position = get_global_position()
			get_tree().get_root().add_child(explosion_instance)
			if body.has_method("handle_hit"):
				body.handle_hit()
			queue_free()
