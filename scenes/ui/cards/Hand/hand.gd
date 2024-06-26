extends HBoxContainer


## Array de card resources?
var cards:Array[Card]
#var CardUI_scene = preload("res://scenes/ui/cards/CardUI/card_ui.tscn")
const TEST_CARD = preload("res://cards/testCard.tres")

func _ready() -> void:
	for i in 5:
		var card:Card = Card.new(TEST_CARD)
		var newCard:CardUI = await CardUI.new_card(card)
		add_child(newCard)
		pass

func addCard():
	pass
	
func killCard(index:int)->int:
	return -1
	pass

