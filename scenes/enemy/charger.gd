extends Enemy

@onready var agent = $NavigationAgent2D
enum {CHASE,CHARGE,WAIT,IDLE,DEAD}
var unit_state := IDLE
var target = Vector2.ZERO
var can_charge = false

func _ready():
	$Hurt_Box.damage = damage
	pass # Replace with function body.

func _process(_delta):
	state_machine()

func update_pathfinding():
	agent.target_position = target
 
func pathfinding():
	if agent.is_navigation_finished():
		update_pathfinding()
		return Vector2.ZERO
	var dir := global_position.direction_to(agent.get_next_path_position())
	var desired_velocity := dir * speed
 
	return desired_velocity

func state_manager():
	if is_dead:
		unit_state = DEAD
		return
	if can_charge:
		unit_state = CHARGE
		return
	
	if GlobalData.player.global_position.distance_to(global_position) > 150:
		unit_state = CHASE
		
		return
	else:
		unit_state = WAIT
		return

func state_machine():
#	print(unit_state)
	match unit_state:
		CHASE:
			$Hit_Box.monitoring = false
			target = GlobalData.player.global_position
			position += pathfinding()
			move_and_slide()

		CHARGE:
			var player_pos = GlobalData.player.global_position
			target = Vector2(player_pos.x,player_pos.y)
			update_pathfinding()
			
			position += pathfinding()
			move_and_slide()
			can_charge = false
			$Hit_Box.monitoring = true

		WAIT:
			await get_tree().create_timer(1).timeout
			can_charge = true
			
		DEAD:
			queue_free()

func _on_hurt_box_area_entered(area):
	if area is Hit_Box and area.is_in_group("player"):
		area.emit_signal("hit_box_take_damage",damage)

	pass # Replace with function body.


func _on_state_timer_timeout():
	state_manager()
	pass # Replace with function body.
