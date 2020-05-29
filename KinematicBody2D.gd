extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 40
const SPEED = 100
const MAX_SPEED = 190
const JUMP_HEIGHT = -550

var motion = Vector2()
var attacking = false

func _ready():
	$AnimatedSprite.connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")

func _physics_process(delta):
	
	$key.play("nokey")
	
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("walk_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walking")
		
	elif Input.is_action_pressed("walk_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walking")
		
	elif Input.is_action_just_pressed("slash"):
			attacking = true
	elif attacking == true:
		$AnimatedSprite.play("slash")
		motion.x = 0
	else:
		$AnimatedSprite.play("idle")
		
		friction = true
		motion.x = lerp(motion.x, 0, 0.2)
	

				
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
			$AnimatedSprite.play("jump")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		$AnimatedSprite.play("jump")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	motion = move_and_slide(motion, UP)
	pass
	
	if is_on_floor():
		if Input.is_action_pressed("crouch") && Input.is_action_pressed("walk_right"):
			$AnimatedSprite.play("crouch")
			motion.x = 75
		if Input.is_action_pressed("crouch"):
			$AnimatedSprite.play("crouch")
		if Input.is_action_pressed("crouch") && Input.is_action_pressed("walk_left"):
			$AnimatedSprite.play("crouch")
			motion.x = -75

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "slash":
		attacking=false

func _on_hitbox_area_entered(area: Area2D)-> void:
		var object = get_node("hitbox").get_collider()
		if Input.is_action_pressed("interact"):
			if object.is_in_group("doors"):
				get_tree().change_scene("res://home1.tscn")
		if object.is_in_group("doors"):
				$key.play("key_w")
