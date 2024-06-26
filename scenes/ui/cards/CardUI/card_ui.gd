class_name CardUI

extends Control

var card:Card
@onready var card_name: Label = $CardName
enum state{
	selected,
	disabled,
	idle
}

static func new_card(card:Card)->CardUI:
	var cardScene = await load("res://scenes/ui/cards/CardUI/card_ui.tscn")
	var instance:CardUI = cardScene.instantiate()
	instance.card = card
	#instance.card_name.text = "guillermo"
	return instance
	pass
	
func playCard():
	pass
	
