extends SimpleStory

const _SWITCH := "It\'s fun, but I am switching to robotics club"
const _DRAMA_DIR := "res://story/drama_club/"

var location := "drama"

var text := [
	"You find Hilda hip-deep in a mess of lights, wires, cables, and stands.",
	'"I [b]love[/b] working on the tech side of theater! Every show gives me new challenges!"',
]

var npc_name := "Hilda"

var options := {
	"I love the challenge, too": {
		"text": '"That\'s why we\'re pally pals!"',
		"effects": {
			"curiosity": +1,
			"resilience": +1,
		},
	},
	_SWITCH: {
		"text": '"Oh, no! Well, I\'m sure you will have a good time. See you around!"',
	},
}


func on_option_selected(option: String, world : World) -> void:
	if option == _SWITCH:
		world.remove_stories(_DRAMA_DIR)
