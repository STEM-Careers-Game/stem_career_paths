class_name EpilogueTextGenerator extends RefCounted

func generate_gap_year_text(_epilogue:Epilogue) -> Array[EpilogueText]:
	return [
		_p("You take a"),
		_h("gap year"),
		_p("to save some money and buy a car."),
	]


func generate_community_college_text(_epilogue:Epilogue) -> Array[EpilogueText]:
	return [
		_p("You attend"),
		_h("Community College"),
		_p("so that you can learn independence, practice college-level study skills, and save tuition money.")
	]


# "p" as in "paragraph" from HTML.
func _p(s:String) -> EpilogueText:
	return EpilogueText.create_paragraph(s)


# "h" as in "heading" from HTML.
func _h(s:String) -> EpilogueText:
	return EpilogueText.create_main_point(s)
