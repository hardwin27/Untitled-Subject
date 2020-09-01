extends Area2D

export var travel_speed = Vector2(1500 , 0)
var direction = Vector2(0.0, 0.0)


func _ready():
	set_process(true)


func _process(delta):
	var speed = direction * travel_speed
	position = position + speed * delta


func _on_screen_exited():
	queue_free()


func _on_Projectile_body_entered(body):
	if body.name == "Player":
		body.damage_taken(20)
	else:
		queue_free()


func set_direction(x_value):
	direction.x = x_value





