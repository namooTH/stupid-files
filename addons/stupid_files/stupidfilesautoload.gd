extends Node

var saveData = {}
func get_data(cag: String, item: String):
	var file = FileAccess.open("user://stupidfile/%s/%s" % [cag.sha256_text(), item.sha256_text()], FileAccess.READ)
	return str_to_var(gzip_decode(file.get_buffer(file.get_length())))
func store(cag: String, item: String, content):
	var dir = setup_cag(cag)
	content = var_to_str(content)
	save_to_file(dir + item.sha256_text(), gzip_encode(content))
func delete(cag: String, item: String = ""):	
	delete_file("user://stupidfile/%s" % cag.sha256_text(), item.sha256_text())

func setup_file_system():
	var dir = DirAccess.open("user://")
	if not "stupidfile" in dir.get_directories():
		dir.make_dir("stupidfile")
	return dir
func setup_cag(cag: String):
	var dir = setup_file_system()
	dir.change_dir("user://stupidfile/")
	if not cag.sha256_text() in dir.get_directories():
		dir.make_dir(cag.sha256_text())
	return "user://stupidfile/%s/" % cag.sha256_text()
	
func delete_file(path: String, file: String):
	var dir = DirAccess.open(path)
	dir.remove(file)
func save_to_file(path: String, content: PackedByteArray):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_buffer(content)
	file.close()
	return file.get_path()
func load_from_file(file_name: String):
	var dir = DirAccess.open("user://")
	if not file_name in dir.get_files():
		return ""
	var file = FileAccess.open("user://%s" % file_name, FileAccess.READ)
	var content = file.get_buffer(file.get_length())
	return gzip_decode(content)

# https://forum.godotengine.org/t/working-example-of-compress-decompress-with-streampeergzip/51831
func gzip_encode(text: String):
	var gzip = StreamPeerGZIP.new()
	gzip.start_compression()
	gzip.put_data(text.to_utf8_buffer())
	gzip.finish()
	return gzip.get_data(gzip.get_available_bytes())[1]
func gzip_decode(data):
	var gzip = StreamPeerGZIP.new()
	gzip.start_decompression()
	gzip.put_data(data)
	return gzip.get_utf8_string(gzip.get_available_bytes())
