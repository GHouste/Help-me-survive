extends Node

@onready var score_show = $Score

# variable storing hearh value
var health = 3
# variable storing score value
var score =0
# variable storing data if player is alive
var alive = true
# variable storing high score value
var high_score = 0

#function removing point
func point_remove(value):
	score -= value
	if score < 0:
		score = 0
	score_show.text = "Score: " + str(score)

func point_added(value):
	score += value
	score_show.text = "Score: " + str(score)

# function that save new high score
func set_high_score(new_score):
	var file = FileAccess.open("user://high_score.txt", FileAccess.WRITE)
	file.store_string("%s" % new_score)

func load_high_score():
	var file = FileAccess.open("user://high_score.txt", FileAccess.READ)
	if FileAccess.file_exists("user://high_score.txt") :
		high_score = file.get_as_text(true).to_int()
	else:
		high_score = 0
		
# function that check if current score is bigger than current high score
func high_score_checker():
	if high_score >= score :
		print(high_score)
	else :
		print(score-20)
		set_high_score(score - 20)
		
func health_system():
	health -= 1
	
	match health:
		2:
			$HBoxContainer/Hearth_Left.texture = load("res://Assets/sprites/hearth_empty.png")
		1:
			$HBoxContainer/Hearth_Center.texture = load("res://Assets/sprites/hearth_empty.png")
		0:
			$HBoxContainer/Hearth_Right.texture = load("res://Assets/sprites/hearth_empty.png")
			alive = false
			print()
			high_score_checker()
# floor hitbox
func _on_area_2d_area_entered(area):
	if area.is_in_group("Head"):
		health_system()
		point_remove(20)

func _ready():
	load_high_score()
	
func _process(delta):
	if alive == false:
		get_tree().paused = true
