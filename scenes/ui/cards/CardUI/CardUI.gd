extends Control

var _cardModel:Card
@onready var name_label: Label = %CardName
@export var card_name: String :set = setCardName

func test():
	pass

#func _init(cardName:String):
	#_cardModel = Card.new(cardName, 1,"",func ():pass)

func setCardName(nName:String):
	card_name = nName
	name_label.text = card_name
	
