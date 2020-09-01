extends Character

export var max_health = 100
var health = max_health
var green_mc = preload("res://Assets/character_roundGreen.png")
var yellow_mc = preload("res://Assets/character_roundYellow.png")
var purple_mc = preload("res://Assets/character_roundPurple.png")
var can_cayote_jump = true
var jump_was_pressed = false
var weapon_used =  null
var sword_path = "res://Object/Weapon/Sword.tscn"

onready var heath_timer = $HealthTimer
onready var health_bar = $HealthBar
onready var sprite = $Sprite
onready var weapon_intance = load(sword_path).instance()
onready var weapon_spawn_point = $Weapon/SpawnPoint


func _ready():
	set_physics_process(true)
	heath_timer.connect("timeout", self, "_on_HealthTimer_timeout")
	
	weapon_spawn_point.add_child(weapon_intance)
	weapon_used = weapon_spawn_point.get_child(0)
	weapon_used.connect("attack_finished", self, "on_player_weapon_attack_finished")
	

func _on_HealthTimer_timeout():
	health_decreased(10)


func _physics_process(delta):
	
	update_character_looks()
	
	if Input.is_action_pressed("left"):
		motion.x = -speed
		sprite.flip_h = true
		$Weapon.scale.x = -1
	elif Input.is_action_pressed("right"):
		motion.x = speed
		sprite.flip_h = false
		$Weapon.scale.x = 1
	else:
		motion.x = 0
		
	if Input.is_action_just_pressed("jump"):
		jump_was_pressed = true
		remember_jump()
		if can_cayote_jump:
			motion.y = jump_height
		
	if is_on_floor():
		can_cayote_jump = true
		if jump_was_pressed:
			motion.y = jump_height	
	else:
		cayote_jump()
		motion.y += gravity
	
	move_and_slide(motion, Vector2.UP)


func _input(event):
	if event.is_action_pressed("attack") and current_state != STATES.ATACK:
		current_state = STATES.ATACK
		health_decreased(2)
		weapon_used.attack()
		$Weapon/AudioStreamPlayer2D.play()


func on_player_weapon_attack_finished():
	current_state = STATES.IDLE


func health_decreased(damage):
	health = health - damage
	health_bar.update_heath_bar(health)
	if health <= 0:
		get_parent().can_spawn = false
		queue_free()


func health_increased(heal):
	health = health + heal
	if health > max_health:
		health = max_health
	health_bar.update_heath_bar(health)


func damage_taken(damage):
	health_decreased(damage)


func update_character_looks():
	if health > max_health * 0.75:
		sprite.texture = green_mc
	elif health > max_health * 0.5:
		sprite.texture = yellow_mc
	elif health > max_health * 0.25:
		sprite.texture = purple_mc


func cayote_jump():
	yield(get_tree().create_timer(0.1), "timeout")
	can_cayote_jump = false


func remember_jump():
	yield(get_tree().create_timer(0.1), "timeout")
	jump_was_pressed = false
