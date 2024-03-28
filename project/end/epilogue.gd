class_name Epilogue extends RefCounted

enum InstitutionType {
	PRIVATE_LIBERAL_ARTS,
	PRIVATE_ENGINEERING,
	SMALL_PUBLIC,
	MEDIUM_PUBLIC,
	LARGE_PUBLIC
}

var character : Character

var gap_year := false

var community_college := true


func _init(character_p:Character) -> void:
	assert(character_p!=null, "Character must be specified")
	character = character_p


@warning_ignore("shadowed_variable")
static func create_for(character:Character) -> Epilogue:
	var epilogue := Epilogue.new(character)
	return epilogue
