class_name Deck

extends Node

signal reset_deck

var _resource:DeckResource: set = setResource, get = getResource
var _deck_name:String: set = setDeckName, get = getDeckName
var _cards:Array[Card]: set = setCards, get = getCards
var _cost:int = 0: get = getCost

func _init(resource:DeckResource) -> void:
	_resource = resource
	if resource.cards: _cards = resource.cards
	if resource.name: _deck_name = resource.name
	_cost = _calculateCost(_cards)
	
#===============================
# Actions
#===============================

## Is this redundant?
func shuffle(cards:Array[Card])->Array[Card]:
	cards.shuffle()
	return cards

func Draw(quantity:int=0):
	if _cards.is_empty():
		return -1
	if quantity < 2:
		return _cards.pop_front()
	else:
		var drawn:Array
		for i in quantity:
			if not _cards.is_empty(): drawn.push_front(_cards.pop_front())
		return drawn

func resetDeck()->void:
	reset_deck.emit(_deck_name)
	if _resource.cards: _cards = _resource.cards
	
func addCard(card:Card)->void:
	pass
#===============================
# Functional
#===============================

func _calculateCost(cards:Array[Card])->int:
	var tempCost = 0
	for card:Card in cards:
		tempCost += card.getCost()
		
	return tempCost


#===============================
# Getters and setters
#===============================

func setResource(res:DeckResource):
	_init(res)
	
func getResource()->DeckResource:
	return _resource

func getDeckName()->String:
	return _deck_name
	
func setDeckName(nName:String)->void:
	_deck_name = nName
	#we modify the resource too?
	
func setCards(cards:Array)->void:
	_cards = cards

func getCards()->Array[Card]:
	return _cards
	pass

func getCost()->int:
	return _cost
