extends Control

@onready var skill_icons_container = $HBoxContainer
@export var player:Player = null

func _process(delta):
	pass

func link_skills_to_icons():
	# The amount and order of childern in the node is expected to be sagnent so I just assign them manualy 
	skill_icons_container.get_children()[0].skill = player.skill_manager.doge_skill
	skill_icons_container.get_children()[1].skill = player.skill_manager.skill_1
	skill_icons_container.get_children()[2].skill = player.skill_manager.skill_2
	skill_icons_container.get_children()[3].skill = player.skill_manager.skill_3
#	skill_icons_container.get_children()[4].skill = player.skill_manager.ultimate_skill
	
	for node in skill_icons_container.get_children():
		node.emit_signal("connect_skill")

func _on_player_ready():
	link_skills_to_icons()
	pass # Replace with function body.
