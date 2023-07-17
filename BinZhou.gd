extends Area2D

export var rotational_speed=PI/5
export var durability=3
export var health_point=3

var life_log="LIFFFFFFE! "

#signal shoot
#signal hit

func _ready():
	pass

func _process(delta):
	show_life()
	if Input.is_action_pressed("turn_left"):
		#print("left")
		rotation+=rotational_speed*delta
	if Input.is_action_pressed("turn_right"):
		#print("right")
		rotation-=rotational_speed*delta

func start(pos):
	position=pos
	show()
	$CollisionShape2D.set_deferred("disabled",false)

func die():
	queue_free()

func show_life():
	$Label.text=life_log+str(health_point)

func _on_BinZhou_body_entered(body):
	health_point-=body.damage
	if health_point<=0:
		die()
	else:
		$HurtSound.play()
