extends PanelContainer

signal dismissed


func _on_button_pressed() -> void:
	dismissed.emit()


## Handle the clicking of the license URL
func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
