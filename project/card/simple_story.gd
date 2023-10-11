class_name SimpleStory extends RefCounted

## The name of the function that can be called when an option is selected,
## if it exists.
const _ON_OPTION_SELECTED_NAME := "on_option_selected"


func run(presenter) -> void:
	assert("text" in self, "This story must have 'text'")
	assert(get("text") is String or get("text") is Array, "The 'text' must be a string or an array")
	assert("options" in self, "This story must have 'options'")

	if "npc_name" in self:
		var npc: Npc = presenter.world.cast.get_by_name(get("npc_name"))
		presenter.show_npc(npc)

	await _show(presenter, get("text"), get("effects"))

	var options_dict = get("options")
	var option_keys = options_dict.keys()
	var selected = await presenter.show_options(option_keys)

	if self.has_method(_ON_OPTION_SELECTED_NAME):
		call(_ON_OPTION_SELECTED_NAME, selected, presenter.world)

	var result = options_dict[selected]
	var selected_text : String = result.text
	var selected_effects = result.effects if "effects" in result else null

	await _show(presenter, selected_text, selected_effects)

	await presenter.finish()


func _show(presenter, text, effects = null):
	if text is String:
		presenter.show_text(text)
	else:
		presenter.show_text(text[0])

	if effects is Dictionary:
		await presenter.show_effects(effects)

	if text is Array:
		for line in text.slice(1):
			await presenter.finish()
			presenter.show_text(line)
