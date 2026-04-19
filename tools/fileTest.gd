@tool
extends EditorScript

const PATH: String = "user://userData.dat"

func _run() -> void:
	writeData()
	
	
func writeData() -> void:
	var file: FileAccess = FileAccess.open(PATH, FileAccess.WRITE)
	if file:
		var info: int = 23
		file.store_32(info)
		file.close()
		
func readData() -> void:
	var file: FileAccess = FileAccess.open(PATH, FileAccess.READ)
	if file:
		var info: int = file.get_32()
		print(info)
		file.close()
