@tool
@icon("res://AI-Brain/Icons/state.svg")
extends AI_Brain
class_name State

const FAILURE = false
const SUCCESS = true

func evaluate(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard) -> bool:
	#this will check child conditions for success or failure
	if get_child_count() == 0:
		return FAILURE
	var child_0 = get_child(0)
	#check that the first child is valid and is a condition
	if (child_0 == null) or !(child_0 is Condition):
		return FAILURE
	#evaluate that first child
	return child_0.evaluate(actor,agent,blackboard)

#go through all of our childen and tick them
func _tick(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard): #process the state
	for c in get_children():
		if c is Action:
			c.tick(actor,agent,blackboard)
	on_tick(actor,agent,blackboard)

#go through all of our children and run their state entered code
func _state_entered(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard): #called once when the state is first entered
	#look through every state and run its state entered
	for c in get_children():
		if c is Action:
			c.action_entered(actor,agent,blackboard)
	on_state_enter(actor,agent,blackboard)


#go through all of our children and run their state exited code
func _state_exited(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard): #called once when the state is exited
	for c in get_children():
		if c is Action:
			c.action_exited(actor,agent,blackboard)
	on_state_exit(actor,agent,blackboard)

func _get_configuration_warnings() -> PackedStringArray:
	var strings : PackedStringArray = []
	if get_child_count() == 0:
		strings.append("this state has no children, it will not function without some condtions and actions")
	else:
		if !(get_child(0) is Condition):
			strings.append("the top level child node is NOT a condition node, this will not function and this state will fail")
	if get_child_count() == 1:
		if (get_child(0) is Condition):
			strings.append("this state has a condition, but no actions, it will not do anything")
	var condition_count : int = 0
	for c in get_children():
		if c is Condition:
			condition_count+=1
		if !(c is Condition) and !(c is Action):
			strings.append("the child " + c.name + " is not a condition or action, it serves no purpose here!")
	if condition_count > 1:
		strings.append("this state has " + str(condition_count) + " conditions, more than one is unnessisary")
	if !(get_parent() is Brain):
		strings.append("this state requires its parent to be a ai brain->brain, it serves no purpose otherwise")
	return strings

func on_tick(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	pass

func on_state_enter(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	pass

func on_state_exit(actor: CharacterBody3D, agent : NavigationAgent3D, blackboard : Blackboard):
	pass
