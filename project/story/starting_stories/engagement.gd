extends SimpleStory

var text := '"Can I tell you something? I feel like I have a hard time making friends."'

var options := {
	"Try being more engaged":
	{
		"text": '"You mean, like, join a club or a team or something. I bet that\'s a good way to meet people."',
		"effects": {
			"engagement": +1,
		}
	},
	"Don\'t feel bad.":
	{
		"text": '"What do you mean? It\'s just how I feel."',
	},
	"Whatever.":
	{
		"text": '"Ha, yeah. I guess. Whatever. ..."'
	}
}
