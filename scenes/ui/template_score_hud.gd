class_name ScoreHUD

extends Control

@onready var player_1_label: Label = %Player1Label
@onready var player_2_label: Label = %player2Label
@onready var message_label: Label = %messageLabel

func setPlayerScore(score:int, playerIndex:int = 1)->void:
	match playerIndex:
		1:
			player_1_label.text = str(score)
		2:
			player_2_label.text = str(score)
		_:
			pass

func setMessage(str:String):
	message_label.text = str

func toggleMessage(flag:bool):
	if flag:
		message_label.show()
	else:
		message_label.hide()

