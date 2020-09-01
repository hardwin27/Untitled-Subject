extends Node2D

onready var health_bar = $HealthBar


func _ready():	
	if get_parent() and get_parent().get("max_health"):
		health_bar.max_value = get_parent().get("max_health")


func update_heath_bar(value):
	health_bar.value = value
