extends VBoxContainer

var epilogue : Epilogue

func _ready() -> void:
	assert(epilogue != null, "Epilogue must be set")
	
	if epilogue.community_college:
		var label := Label.new()
		label.text = "Attended Community College"
		add_child(label)
