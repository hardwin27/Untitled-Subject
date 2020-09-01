extends Character

var max_health = 3
var health = max_health
var audio_playing = false
onready var sprite = $Sprite
onready var green_enemy = preload("res://Assets/character_squareGreen.png")
onready var yellow_enemy = preload("res://Assets/character_squareYellow.png")
onready var purple_enemy = preload("res://Assets/character_squarePurple.png")


func _ready():
	update_enemy_look()
	speed = 200
	set_physics_process(true)
	motion.x = self.scale.x * speed


func _physics_process(delta):
	if is_on_floor():
		if !audio_playing:
			$AudioStreamPlayer2D.play()
			audio_playing = true
	
	if !is_on_floor():
		motion.y += gravity
		if audio_playing:
			$AudioStreamPlayer2D.stop()
			audio_playing = false
		
	if is_on_wall():
		self.scale.x *= -1.0
		motion.x *= -1
	
	move_and_slide(motion, Vector2.UP)


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


func _on_Weapon_body_entered(body):
	body.damage_taken(10)
