extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var currentState : State

var states : Array[State]


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Node:
			states.append(child)
			#set the states up with what they need to function
		else:
			push_warning(child.name + " in player scene isn't a Node")

func check_if_can_move():
	return currentState.can_move
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
