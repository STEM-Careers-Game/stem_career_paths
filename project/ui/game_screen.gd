## This is the "presenter" of the architecture.
## Its public methods are called by the story model in order to display
## results. Many of the methods are coroutines.
extends Control

signal _option_selected(option: String)
signal _tapped_anywhere

var world : World:
	set(value):
		world = value
		%CharacterDisplay.character = world.character
		%YearIndicator.world = world

@onready var _advance_anim_player := %AdvanceInstructionsAnimator

## This box holds the whole top interaction area. It is the container
## whose content is swapped out by the ending screen at the end of
## the game, which allows the bottom to stay in place.
@onready var _top_container := %TopContainer
@onready var _option_area := %OptionArea
@onready var _story_label : Label = %StoryLabel
@onready var _npc_panel_container := %NpcPanelContainer

var _npc_panel : Control


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		_tapped_anywhere.emit()


## Finish an interaction with the presenter. 
## This gives the player a chance to confirm that they are done with the
## current story.
##
## This is a coroutine.
func finish() -> void:
	_clear(_option_area)
	
	var button := preload("res://ui/audible_button.tscn").instantiate()
	button.text = "OK"
	_option_area.add_child(button)
	await button.pressed
	
	_clear(_option_area)


## Finish the entire game
func finish_game() -> void:
	var ending_control := preload("res://ui/game_over_control.tscn").instantiate()
	var ending_factory := preload("res://end/ending_factory.gd").new()
	var ending := ending_factory.make_ending_story(world)
	ending_control.major = ending.major
	ending_control.text = ending.text
	_clear(_top_container)
	_top_container.add_child(ending_control)
	
	# Right now, there's only one option, so when it's chosen, move on.
	# This will have to be more robust later.
	await show_options(["Play Again"])


## Show the player the effects of their decision.
##
## The parameter is a dictionary that maps character attribute names
## to numbers representing the change to that attribute (e.g. +1, -2).
##
## This function does not change the world state: it only shows an animation.
##
## This is a coroutine that returns when the animated effects are complete.
func show_effects(_effects: Dictionary) -> void:
	# Remember that the animations were cut out while we revise the UI.
	pass


## Show the portrait of a particular npc.
##
## This is a coroutine that ends with the animation's completion.
func show_npc(npc:Npc) -> void:
	if _npc_panel != null:
		_npc_panel.queue_free()
	_npc_panel = preload("res://ui/npc_panel.tscn").instantiate()
	_npc_panel.npc = npc
	_npc_panel_container.add_child(_npc_panel)
	# Be careful to put the new child _beneath_ the advance instructions control
	# and above the background.
	# This makes sure the "tap to advance" instruction shows over it.
	_npc_panel_container.move_child(_npc_panel, 1)


## Show options to the player and await for them to select one.
## The selected option is returned.
func show_options(options: Array) -> String:
	var buttons : Array[Control] = []
	for option in options:
		var button := preload("res://ui/audible_button.tscn").instantiate()
		button.text = option
		button.pressed.connect(func(): _option_selected.emit(option))
		_option_area.add_child(button)
		buttons.append(button)

	var selection = await _option_selected
	GameLog.made_choice(selection)

	for button in buttons:
		button.disabled = true

	return selection


## Show text in the main message area.
##
## The parameter may be a String or an Array[String].
##
## This is a coroutine that returns when the text (or the last page of text)
## has been shown.
func show_text(story) -> void:
	if story is String:
		_story_label.text = story
		
	elif story is Array:
		for i in story.size():
			var substory : String = story[i]
			_story_label.text = substory
			
			# If this is not the last substory, let the player click through.
			if i < story.size()-1:
				_advance_anim_player.play("show_advance_instructions")
				await _tapped_anywhere
				_advance_anim_player.stop()
				_advance_anim_player.play("RESET")

	else:
		push_error("Unexpected parameter type: " + story.get_class())


## Remove all the children from the given container.
func _clear(container:Control) -> void:
	while container.get_child_count() > 0:
		container.remove_child(container.get_child(0))
