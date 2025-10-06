extends StaticBody2D



# connection to monkeytrhower sprite
@onready var sprite = $AnimatedSprite2D

#preloading head scene
var head_prelode = preload("res://Scenes/head.tscn")
#preloading hearth scene
var hearth_prelode = preload("res://Scenes/hearth.tscn")
#position of the monkey thrower
var pos = Vector2(0, -249)

# Starting a random number generator
var rng = RandomNumberGenerator.new()

# function shooting head and hearth from monkey thrower position
func shooting(pos):
	#randomizing if you shood head or hearth
	match rng.randi_range(0,100):
		10, 20, 30, 40, 50, 60, 70, 80, 90, 100:
			var hearth = hearth_prelode.instantiate()
			hearth.position = pos
			owner.add_child(hearth)
			
		_:
			var head = head_prelode.instantiate()
			head.position = pos
			owner.add_child(head)



# Teleporting monkey thrower to the start location and starting a timer
func _ready():
	global_position = Vector2(0, -270)
	$countdown.start()

# shooting when animation of monkey thrower end.
func _on_animation_finished(anim_name):
	shooting(pos)
	
	
# When timer goes to 0 function teleport monkey thrower to diffrent location and shoot bullet
func _on_countdown_timeout():
	match rng.randi_range(0, 8):
		0, 3, 6:
			global_position = Vector2(-316, -270)
			sprite.play("monkey_thrower")
			_on_animation_finished("monkey_thrower")
			pos = Vector2(-316, -249)
		1, 4, 7:
			global_position = Vector2(0, -270)
			_on_animation_finished("monkey_thrower")
			pos = Vector2(0, -249)
		2, 5, 8:
			global_position = Vector2(303, -270)
			sprite.play("monkey_thrower")
			_on_animation_finished("monkey_thrower")
			pos = Vector2(303, -249)
