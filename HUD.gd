extends CanvasLayer

signal start_game

func _ready():
	pass # Replace with function body.

func show_message(text):
	$MessageLabel.text=text
	$MessageLabel.show()
	pass

func show_game_over():
	$MessageLabel.text="我的宾啊！"
	$MessageLabel.show()
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text=str(score)

func _on_StartButton_pressed():
	$MessageLabel.hide()
	$StartButton.hide()
	$ScoreLabel.show()
	emit_signal("start_game")
