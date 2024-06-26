class_name CardUI

extends Control

var card:Card
@onready var card_name: Label = $CardName
enum state{
	selected,
	disabled,
	idle
}

func _setupCard():
	if self.card == null: return -1
	card_name.text = self.card.getName()
	

func _ready() -> void:
	_setupCard()
	pass

static func new_card(card:Card)->CardUI:
	var cardScene = await load("res://scenes/ui/cards/CardUI/card_ui.tscn")
	var instance:CardUI = cardScene.instantiate()
	instance.card = card
	return instance
	pass
	
func playCard():
	pass
	
