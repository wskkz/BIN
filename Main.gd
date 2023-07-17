extends Node

export (PackedScene) var shooter_scene
export (PackedScene) var arrow_scene
export (PackedScene) var BinLa_scene

#export var cooldown=1.0

var score=0
var screen_size
var loaded_flag=false

var shooter
var arrow

func _ready():
	randomize()
	$BGMPlayer.play()
#	new_game()

func _process(delta):
	#print(score)
	arrow=arrow_scene.instance()
	
	if Input.is_action_just_pressed("shoot"):
		if loaded_flag:
			shoot(arrow)
			loaded_flag=false
		else:
			pass
			
	#get_tree().call_group("BinLas","get_score",score)#left to be checked

func set_shooter(shooter):
	shooter.start($StartPosition.position)
	add_child(shooter)

func shoot(arrow):
	arrow.position=shooter.position
	arrow.rotation=shooter.rotation
	var velocity=Vector2(arrow.speed,0.0)
	arrow.linear_velocity=velocity.rotated(arrow.rotation)
	arrow.show()
	add_child(arrow)
	$ZapSound.play()

func new_game():
	get_tree().call_group("BinLas","queue_free")
	shooter=shooter_scene.instance()#引用新的shooter实例
	score=0
	set_shooter(shooter)
	$BinLaTimer.start()
	$CooldownTimer.start()

func game_over():
	$CooldownTimer.stop()
	$BinLaTimer.stop()
	$HUD.show_game_over()
	$LaughSound.play()
	$BGMPlayer.stop()
	pass

func _on_CooldownTimer_timeout():
	loaded_flag=true
	$CooldownTimer.start()

func _on_BinLaTimer_timeout():
	var BinLa=BinLa_scene.instance()
	var BinLa_spawn_location=get_node("BinLaPath/BinLaSpawnLocation")
	BinLa_spawn_location.offset=randi()
	BinLa.position=BinLa_spawn_location.position
	var direction=BinLa_spawn_location.rotation+PI/2#垂直于刷怪路径
	direction+=rand_range(-PI/4,+PI/4)
	BinLa.rotation=direction
	var velocity=Vector2(rand_range(BinLa.min_speed,BinLa.max_speed),0.0)#有缩短空间
	BinLa.linear_velocity=velocity.rotated(direction)
	add_child(BinLa)

func _on_Main_child_exiting_tree(node):
	#得分函数
	#print("et")
	if node.is_in_group("BinLas") and not node.alive_flag:
		score+=1
		print(node)
		print(score)
		$HUD.update_score(score)
		$BoomSound.play()
	if node.get_name()=="BinZhou":
		game_over()
	pass

func _on_BGMPlayer_finished():
	$BGMPlayer.play()
