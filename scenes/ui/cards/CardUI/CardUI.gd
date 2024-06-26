class_name CardUI

extends Control

@export var card_res: CardResource
@export var card_name: String :set = setCardName
@onready var name_label: Label = %NameLabel

#const card_scene = preload("res://scenes/ui/cards/CardUI/CardUI.tscn") 

static func new_card(resource:CardResource=null):
	#var newCard = card_scene.instantiate()
	#return newCard
	pass
	

#func _init(cardName:String):
	#_cardModel = Card.new(cardName, 1,"",func ():pass)
func _ready():
	pass


func setCardName(nName:String):
	#if card_res != null: card_res.name = nName
	#card_name = nName
	#print_debug(card_name)
	#print_debug(nName)
	#name_label.text = "guillermo"
	pass
	

func getCardName()->String:
	card_name = card_res.name
	name_label.text = card_name
	return card_name
