extends CharacterBody2D

#connection to sprite
@onready var sprite = $Sprite2D

#gettin gravity from project setting
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Function updating every frame
func _physics_process(delta):
	# Adding gravity
	if not is_on_floor():
		velocity.y += (gravity* delta)/2
	# Making sprite spin
	sprite.rotate(0.1)
	
	move_and_slide()

# making it dissapear
func _on_area_2d_area_entered(area):
	queue_free()
