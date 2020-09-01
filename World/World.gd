extends Node2D

var rng = RandomNumberGenerator.new()
var enemy_ranged_path = "res://Character/EnemyRanged.tscn"
var enemy_melee_path= "res://Character/EnemyMelee.tscn"
var can_spawn = true

onready var spawners = [$Spawner, $Spawner2, $Spawner3, $Spawner4, $Spawner5, $Spawner6, $Spawner7, $Spawner8, $Spawner9, $Spawner10, $Spawner11, $Spawner12]


func _ready():
	rng.randomize()
	
	
func _unhandled_input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _on_SpawnTimer_timeout():
	if can_spawn:
		var enemy_choice = rng.randi_range(0, 1)
		var enemy = null
		if enemy_choice == 0:
			enemy = load(enemy_melee_path).instance()
			enemy.scale.x = -1
		else:
			enemy = load(enemy_ranged_path).instance()
		self.add_child(enemy)
		enemy.set_global_position(spawners[rng.randi_range(0, 11)].get_global_position())
