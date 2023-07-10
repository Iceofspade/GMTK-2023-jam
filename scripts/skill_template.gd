extends Node2D

class_name Skill_Template
signal cooldown_finished
signal cooldown_started
@export var power :int= 1
@export var cooldown_time :float= 0.5
@export var damage :float= 1.0

enum skill_types {BASIC,DOGE,ULITMATE,NONE}

var skill_owner:Player = null
var on_cooldown:bool = false
@export var skill_type:= skill_types.NONE


func _ready():
	cooldown_started.connect(_on_cooldown_started)
	cooldown_finished.connect(_on_cooldown_finished)
# The core trigger for any skill.

func activate_skill():
	print("An empty skill was used!!!")
	
func _on_cooldown_finished():
	on_cooldown = false

func _on_cooldown_started():
	on_cooldown = true
