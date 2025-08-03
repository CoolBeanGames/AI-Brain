@tool
@icon("res://AI-Brain/Icons/action.svg")
extends AI_Brain
class_name Action

@export var commands : Array[Command] # a list of commands to carry out


func tick(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	for c in commands:
		c.tick(actor,agent,blackboard)
	on_tick(actor,agent,blackboard)

func action_entered(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	for c in commands:
		c.action_entered(actor,agent,blackboard)
	on_action_enter(actor,agent,blackboard)

func action_exited(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	for c in commands:
		c.action_exited(actor,agent,blackboard)
	on_action_exit(actor,agent,blackboard)

func _get_configuration_warnings() -> PackedStringArray:
	var strings : PackedStringArray = []
	if commands.size() == 0:
		strings.append("this action requires some commands to be functional, right now it does nothing")
	if !(get_parent() is State):
		strings.append("this action MUST be a child of a state to function")
	return strings

func on_tick(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	pass

func on_action_enter(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	pass

func on_action_exit(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	pass
