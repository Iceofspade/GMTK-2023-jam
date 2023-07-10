extends Skill_Template

@export var imunnity_duration = 0.9

func activate_skill():
	disable_hit_box()

func disable_hit_box():
	skill_owner.hit_box.monitorable = false
	$imunnity_timer.start(imunnity_duration)
	$cooldown.start(cooldown_time)
	emit_signal("cooldown_started")
	$ColorRect.visible = true

func _on_imunnity_timer_timeout():
	$ColorRect.visible = false
	pass # Replace with function body.

func _on_cooldown_timeout():
	emit_signal("cooldown_finished")
	pass # Replace with function body.
