@tool
@icon("res://AI-Brain/Icons/condition.svg")
extends AI_Brain
class_name Condition

const FAILURE = false
const SUCCESS = true

@export var Requirements : Array[Requirement]

#make sure this is a child of a state, otherwise remove it
func _ready() -> void:
	if !get_parent() is State:
		queue_free()

#returns if the state can be entered
func evaluate(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard) -> bool:
	for r in Requirements:
		if r.evaluate(actor,agent,blackboard) == FAILURE:
			return FAILURE
	return SUCCESS

func _get_configuration_warnings() -> PackedStringArray:
	var strings : PackedStringArray = []
	if Requirements.size() == 0:
		strings.append("this condition requires some requirements to be functional, right now it does nothing")
	if !(get_parent() is State):
		strings.append("this condition MUST be a child of a state to function")
	if (get_parent().get_child(0) != self):
		strings.append("this condition is not the first child of the parent state, it will not function as is")
	return strings
