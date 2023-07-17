extends RigidBody2D

export var max_speed=50.0
export var min_speed=10.0
export var health_point=1
export var damage=1

var alive_flag=true

func _ready():
	contacts_reported=health_point

#func get_score(score):#left to be checked
#	#print("get score")
#	if alive_flag:
#		pass
#	else:
#		score+=1
	#print(score)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_BinLa_body_entered(body):
	#print("be")
	health_point-=body.damage
	if health_point<=0:
		alive_flag=false
		queue_free()
	else:
		pass
