extends CharacterBody2D

class_name Player
@export var health = 100
@export var speed:float = 3000.0
@export var rotation_speed:float=PI/2
@onready var skill_manager:Node2D = $skills_manager
@onready var hit_box = $Hit_Box
@onready var health_bar = $"health bar"
@onready var sprite = $Sprite2D
var direction:Vector2=Vector2(0,0)
var  rotation_direction:int=0
var is_dead = false


func _ready():
 
	GlobalData.player = self
	skill_manager.load_skills()
	health_bar.max_value = health
	health_bar.value = health

func update_health(amount):
	if health-amount <= 0:
		health = 0
		is_dead = true
		GlobalData.emit_signal("game_over")
	else:
		health-=amount
	health_bar.value  = health
	print("HP is now "+str(health))
	
func _physics_process(delta):
	if is_dead:
		return
	movement(delta)
	use_skill()
	
func movement(delta_time:float):
	var direction:Vector2 = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
#	if Input.is_action_just_pressed("Move_Up"):
#		direction=Vector2(0,-1)
#	else:
#		if Input.is_action_just_released("Move_Up"):
#			direction=Vector2(0,0)
#	if  Input.is_action_just_pressed("Move_Down"):
#		direction=Vector2(0,1)
#	else:
#		if Input.is_action_just_released("Move_Down"):
#			direction=Vector2(0,0)
#	if Input.is_action_just_pressed("Move_Left"):
#		rotation_direction=-1
#	else:
#		if Input.is_action_just_released("Move_Left"):
#			rotation_direction=0
#	if  Input.is_action_just_pressed("Move_Right"):
#		rotation_direction=1
#	else:
#		if Input.is_action_just_released("Move_Right"):
#			rotation_direction=0

	if direction:
		velocity = (direction.rotated(rotation) * speed*delta_time) 
		rotation=rotation+(rotation_direction*rotation_speed*delta_time)
		sprite.play("moving")
	else:
		sprite.play("Idle")
		velocity = Vector2.ZERO

	move_and_slide()
 
func use_skill():
	if Input.is_action_just_pressed("Doge") and !skill_manager.doge_skill.on_cooldown:
		skill_manager.doge_skill.activate_skill()
	if Input.is_action_just_pressed("Skill_1") and !skill_manager.skill_1.on_cooldown:
		skill_manager.skill_1.activate_skill()
	if Input.is_action_just_pressed("Skill_2") and !skill_manager.skill_2.on_cooldown:
		skill_manager.skill_2.activate_skill()
	if Input.is_action_just_pressed("Skill_3") and !skill_manager.skill_3.on_cooldown:
		skill_manager.skill_3.activate_skill()
#	if Input.is_action_just_pressed("Ultimate") and !skill_manager.ultimate_skill.on_cooldown:
#		skill_manager.ultimate_skill.activate_skill()

func _on_hit_box_hit_box_take_damage(damage):
	update_health(damage)
	sprite.play("hurt")
	pass # Replace with function body.
