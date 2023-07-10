extends Skill_Template

@onready var projectile:= $projectile
@onready var cooldown_timer := $cooldown_timer
@onready var projectile_texture:= $projectile/Icon
@export var fire_rate = 0.5
var can_fire = true
@export var projectile_speed = 1
@export var number_of_projectiles = 1

func _ready():
	projectile.global_position = global_position
	projectile.visible = false
	projectile.speed = 0
	projectile.monitorable = false
	projectile.monitorable = false
	pass

func _process(delta):
	look_at(get_global_mouse_position())

func create_projectile():
	var bullet = projectile.duplicate()
	bullet.global_position = global_position
	bullet.angle = rotation
	bullet.visible = true
	bullet.speed = projectile_speed
	bullet.monitorable = true
	bullet.monitorable = true
	bullet.damage_group = "enemy" 
	bullet.damage = damage
	get_tree().root.add_child(bullet)
	print("bullet was made")
	return bullet

func shoot():
	if can_fire:
		can_fire = false
		create_projectile()
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
# Assign the angle when th projectile is created to have it pointed and travel in the right direction
func activate_skill():
	for i in number_of_projectiles:
		await shoot()
	cooldown_timer.start(cooldown_time)
	emit_signal("cooldown_started")
	pass

func _on_cooldown_timer_timeout():
	emit_signal("cooldown_finished")
	pass # Replace with function body.

