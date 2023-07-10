extends Area2D

class_name Hurt_Box
var damage := 1
@export var damage_group = ""

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_area_entered(area):
	if area is Hit_Box and area.is_in_group(damage_group):
		area.emit_signal("hit_box_take_damage",damage)


