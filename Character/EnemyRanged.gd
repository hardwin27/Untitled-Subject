extends Character

var max_health = 3
var health = max_health
onready var direaction_timer = $DirectionTimer
onready var attack_timer = $AttackTimer
onready var sprite = $Sprite
onready var green_enemy = preload("res://Assets/character_squareGreen.png")
onready var yellow_enemy = preload("res://Assets/character_squareYellow.png")
onready var purple_enemy = preload("res://Assets/character_squarePurple.png")
onready var projectile_path = "res://Object/Weapon/Projectile.tscn"


func _ready():
	update_enemy_look()


func _on_DirectionTimer_timeout():
	self.scale.x = self.scale.x * -1


func _on_AttackTimer_timeout():
	var projectile = load(projectile_path).instance()
	projectile.set_direction(self.scale.x)
	get_parent().add_child(projectile)
	projectile.set_global_position($Weapon/ProjectilePosition.get_global_position())
	$Weapon/AudioStreamPlayer2D.play()


func update_enemy_look():
	if health > 2:
		sprite.texture = green_enemy
	elif health > 1:
		sprite.texture = yellow_enemy
	elif health > 0:
		sprite.texture = purple_enemy
	else:
		queue_free()


func damage_taken(damage):
	health = health - damage
	update_enemy_look()
