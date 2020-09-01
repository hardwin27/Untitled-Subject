extends Area2D

signal attack_finished

onready var animation_player = $AnimationPlayer


func _on_AnimationPlayer_animation_finished(anim_name):
	animation_player.play(("Idle"))
	emit_signal("attack_finished")


func _on_Sword_body_entered(body):
	$AudioStreamPlayer2D.play()
	get_parent().get_parent().get_parent().health_increased(20)
	body.damage_taken(1)


func attack():
	animation_player.play("Attack")
