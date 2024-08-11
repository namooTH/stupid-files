extends Node

func _ready() -> void:
	StupidFiles.store("hello", "world", true)
	print(StupidFiles.get_data("hello", "world"))
	StupidFiles.delete("hello", "world")
