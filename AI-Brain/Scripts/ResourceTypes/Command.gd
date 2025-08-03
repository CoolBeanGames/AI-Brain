@icon("res://AI-Brain/Icons/command.svg")
extends Resource
class_name Command

#this again is meant for overriding, and should define what the command actually does
func tick(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	on_tick(actor,agent,blackboard)

#this will be overridden as well
func action_entered(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	on_action_enter(actor,agent,blackboard)

#this will also be overidden
func action_exited(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	on_action_exit(actor,agent,blackboard)

func on_tick(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	pass

func on_action_enter(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	pass

func on_action_exit(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	pass
