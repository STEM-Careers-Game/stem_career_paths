class_name EpilogueTextGenerator extends RefCounted

func generate_gap_year_text(_epilogue:Epilogue) -> Array[EpilogueText]:
	return [
		EpilogueText.create_paragraph("You take a"),
		EpilogueText.create_main_point("gap year"),
		EpilogueText.create_paragraph("to save some money and buy a car."),
	]


func generate_community_college_text(_epilogue:Epilogue) -> Array[EpilogueText]:
	return [
		EpilogueText.create_paragraph("You attend"),
		EpilogueText.create_main_point("Community College"),
		EpilogueText.create_paragraph("so that you can learn independence, practice college-level study skills, and save tuition money.")
	]
