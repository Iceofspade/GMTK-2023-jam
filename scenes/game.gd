extends Node2D

@onready var simplitin = preload("res://scenes/enemy/simpletin.tscn")
# Called when the node enters the scene tree for the first time.
var score = 0
func _ready():
	GlobalData.enemy_die.connect(update_score)
	GlobalData.game_over.connect(game_over)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$"player/Camera2D/game over".visible = true
	await get_tree().create_timer(5).timeout
	$"player/Camera2D/game over".visible = false
	get_tree().change_scene_to_file("res://scenes/menue.tscn")
	
func update_score():
	score+= randi_range(10,50)
	$player/Camera2D/Label.text = "Score: "+str(score)

func spawn_enemy(location:Vector2):
	var enemy = simplitin.instantiate()
	enemy.position = location
	add_child(enemy)
	print("enemy made")
	
func spawn_set_of_enemies(size=1):
	for i in range(size):
		var spawn_pos =  Vector2(randi_range(800,900),randi_range(10,100))
		spawn_pos.x*= randi_range(-1,1)
		spawn_pos.y*= randi_range(-1,1)
		while (spawn_pos.x == 0 or spawn_pos.y == 0) and spawn_pos == Vector2.ZERO  and $TileMap.get_cell_source_id(0,spawn_pos) == -1:
			print(spawn_pos)
			spawn_pos.x*= randi_range(-1,1)
			spawn_pos.y*= randi_range(-1,1)

		spawn_enemy(spawn_pos)

func _on_timer_timeout():
	$Timer.start(randi() % 5)
	spawn_set_of_enemies(randi() % 10)
	pass # Replace with function body.
