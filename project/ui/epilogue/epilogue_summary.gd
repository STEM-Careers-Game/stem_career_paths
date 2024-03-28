extends VBoxContainer

var epilogue : Epilogue

func _ready() -> void:
	assert(epilogue != null, "Epilogue must be set")
	
	if epilogue.gap_year:
		var label := Label.new()
		label.text = "Took a gap year"
		add_child(label)
	
	if epilogue.community_college:
		var label := Label.new()
		label.text = "Attended Community College"
		add_child(label)
