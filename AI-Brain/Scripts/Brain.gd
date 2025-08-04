@tool
@icon("res://AI-Brain/Icons/brain.svg")
extends AI_Brain
class_name Brain

const FAILURE = false
const SUCCESS = true

@export var blackboard : Blackboard = Blackboard.new()
@export var current_state : State
@export var actor : CharacterBody3D
@export var agent : NavigationAgent3D
var actor_name : String

signal state_changed(new_state : State)

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	if actor:
		actor_name = actor.name

#check and see what our current state is
func process_states():
	for c in get_children(): #look through all the children
		if c is State: #make sure the child is a state
			if c.evaluate(actor,agent,blackboard) == SUCCESS: #if the state succeeds then enter that state
				if !c == current_state: #are we already in that state?
					if current_state: #is there already a current state? if so exit it
						current_state._state_exited(actor,agent,blackboard) 
					c._state_entered(actor,agent,blackboard) #enter the new state
					current_state = c
					state_changed.emit(c)
				break
		else:
			print("child was not a state")

func tick():
	if current_state:
		current_state._tick(actor,agent,blackboard) #process our current state
	pass

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	process_states()
	tick()
	if current_state != null:
		actor.name = actor_name + "[" + current_state.name  + "]s"

func _get_configuration_warnings() -> PackedStringArray:
	var strings : PackedStringArray = []
	if get_child_count() == 0:
		strings.append("this brain has no children, it will not function without some states")
	else:
		for c in get_children():
			if !(c is State):
				strings.append("the child: " + c.name + " is not a state, it may throw errors and serves no purpose here")
	if actor == null:
		strings.append("this brain does not have a CharacterBody3D assigned to its actor slot, this is required for functionality")
	if agent == null:
		strings.append("this brain does not have a NavigationAgent3D assigned to its agent slot, this is required for functionality")
	return strings
