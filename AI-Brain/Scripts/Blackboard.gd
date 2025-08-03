@icon("res://AI-Brain/Icons/blackboard.svg")
extends Resource
class_name Blackboard


const FAILURE = false
const SUCCESS = true

@export var data : Dictionary

func set_data(key, value):
	data[key] = value

func get_data(key, default):
	return data.get(key,default)

func has_data(key):
	return data.has(key)

func erase_data(key):
	if has_data(key):
		data.erase(key)

func clear_blackboard():
	data.clear()
