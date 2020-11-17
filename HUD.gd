extends CanvasLayer


onready var health_bar = $HealthBar
onready var ammo = $CurrentAmmo

var player: Player

func set_player(player: Player):
	self.player = player
	
	set_new_health_value(player.health_stat.health)
	set_current_ammo(player.current_ammo)
	
	player.connect("player_health_changed", self, "set_new_health_value")

func set_new_health_value(new_health: int):
	health_bar.value = new_health

func set_current_ammo(new_ammo: int):
	pass
