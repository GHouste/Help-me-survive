extends CharacterBody2D


const SPEED = 500.0

# connection to game manager
@onready var manager = %"Game Manager"
# connection to player sprite
@onready var sprite = $AnimatedSprite2D

func _on_area_2d_area_entered(area):
	if area.is_in_group("Head"):
		manager.point_added(10)
	elif area.is_in_group("Hearth"):
		manager.point_added(30)


func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	# get input direction: -1 0 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# playing animation
	if direction ==0:
		sprite.play("Idle")
	else:
		sprite.play("Moving")
		
	#flip a sprite
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
	
	#move the player
	if direction:
		velocity.x = direction * SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
