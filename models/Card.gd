class_name Card

extends Node

var _card_res:CardResource
var _name:String :set = setName , get=getName
var _cost:int :set = setCost , get=getCost
var _effect:String :set = setEffect , get=getEffect
var _action:Callable :set = setAction , get=getAction


func _init(res:CardResource):
	_card_res = res
	if res.name: setName(res.name)
	if res.cost: setCost(res.cost)
	if res.name: setEffect(res.name)
	if res.name: setName(res.name)
	pass


#=================================
# GETTERS AND SETTERS
#=================================

func setEffect(nEffect:String)->void:
	_effect = nEffect

func getEffect()->String:
	return _effect

func setName(nName:String)->void:
	_name = nName
	
func getName()->String:
	return _name
	
func setCost(nCost:int)->void:
	_cost = nCost
	
func getCost()->int:
	return _cost
	
func setAction(nAction:Callable)->void:
	_action = nAction

func getAction()->Callable:
	return _action
	
func useCard()->void:
	_action.call()
