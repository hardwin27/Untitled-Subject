class_name Character
extends KinematicBody2D

enum STATES {IDLE, ATACK}

export var motion = Vector2()
export var gravity = 40
export var jump_height = -800
export var speed = 500
var current_state = STATES.IDLE
