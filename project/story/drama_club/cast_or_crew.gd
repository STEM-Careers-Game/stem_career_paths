extends SimpleStory

var text := '"I love Drama Club! Do you want to be in the cast or help me with the tech side of things?"'

var npc_name := "Aubrey"

var options := {
	"I was born for the stage!": {
		"text": '"You sure were, my friend! Break a leg! Or several!"',
		"effects": {
			"resilience": +1,
		}
	},
	"Tech": {
		"text": '"Lighting, construction, microphones... this is fun!"',
		"effects": {
			"technology": +1
		}
	}
}
