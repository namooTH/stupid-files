extends Node

func _ready() -> void:
	# creates a catagory called "hello" with the item called "world" with a value true
	StupidFiles.store("hello", "world", true)
	# prints the value
	print(StupidFiles.get_data("hello", "world"))
	# deletes the item
	StupidFiles.delete("hello", "world")
