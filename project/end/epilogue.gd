class_name Epilogue extends RefCounted

## Probability of taking a gap year
##
## This is completely made up. We could do some research for better data here.
const GAP_YEAR_CHANCE := 0.15

## Probability of going to 2-year college vs 4-year college
##
## This is computed by the ratio reported by NCES in 2019.
const COMMUNITY_COLLEGE_PROBABILITY := 0.22/0.66

enum InstitutionType {
	PRIVATE_LIBERAL_ARTS,
	PRIVATE_ENGINEERING,
	SMALL_PUBLIC,
	MEDIUM_PUBLIC,
	LARGE_PUBLIC
}

var character : Character

var gap_year := false

var community_college := false

var college_type : InstitutionType = InstitutionType.MEDIUM_PUBLIC


func _init(character_p:Character) -> void:
	assert(character_p!=null, "Character must be specified")
	character = character_p


@warning_ignore("shadowed_variable")
static func create_for(character:Character) -> Epilogue:
	var epilogue := Epilogue.new(character)
	
	if randf() < GAP_YEAR_CHANCE:
		epilogue.gap_year = true
	
	if randf() < COMMUNITY_COLLEGE_PROBABILITY:
		epilogue.community_college = true
	
	# Even chance of the institution types. This can be improved later as desired.
	epilogue.college_type = InstitutionType.keys().pick_random()
	
	return epilogue


static func as_string(type:InstitutionType) -> String:
	match type:
		InstitutionType.PRIVATE_LIBERAL_ARTS: 
			return "private liberal arts college"
		InstitutionType.PRIVATE_ENGINEERING:
			return "private engineering college"
		InstitutionType.SMALL_PUBLIC:
			return "small public college"
		InstitutionType.MEDIUM_PUBLIC:
			return "mid-sized public university"
		InstitutionType.LARGE_PUBLIC:
			return "large public university"
	assert(false, "Unreachable code if the match is working above.")
	return ""
