extends RigidBody2D

export var speed=100.0
export var damage=1

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Biu_body_entered(body):
	#print("bbe")
	pass
