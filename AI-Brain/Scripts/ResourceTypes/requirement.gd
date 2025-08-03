@icon("res://AI-Brain/Icons/requirement.svg")
extends Resource
class_name Requirement

const FAILURE = false
const SUCCESS = true

#this is meant for overriding but it will be check if the condition is valid
func evaluate(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard) -> bool:
	return FAILURE
