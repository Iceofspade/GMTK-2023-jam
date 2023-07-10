extends Skill_Template

@export var swings_per_attack = 1
@export var swing_delay = 0.5
# Called when the node enters the scene tree for the first time.
func activate_skill():
	swing_attack()
	

func swing_attack():
	$Polygon2D/Hurt_Box.damage = damage
	for i in swings_per_attack:
		$Polygon2D/Hurt_Box.monitoring = true
		$Polygon2D.visible = true
		await get_tree().create_timer(swing_delay).timeout
		$Polygon2D/Hurt_Box.monitoring = false
		$Polygon2D.visible = false
	$cooldown.start(cooldown_time)
	emit_signal("cooldown_started")

func _on_cooldown_timeout():
	emit_signal("cooldown_finished")
	pass # Replace with function body.

func _process(delta):
	look_at(get_global_mouse_position())
