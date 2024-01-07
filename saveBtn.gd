extends Button

var hangerList = []
#var itemList = inventory.hangerList

#var data:Dictionary={}
var data = {
	"sword": {
		"icon": "sword.png",
		"slot": "MAIN_HAND"
	},
	"breastplate": {
		"icon": "breastplate.png",
		"slot": "CHEST"
	},
	"potato": {
		"icon": "potato.png",
		"slot": "NONE"
	},
	"error": {
		"icon": "error.png",
		"slot": "NONE"
	}
}

func open_link(url):
	var os = OS.get_singleton()
	if os and os.has_feature(OS.OS_FEATURE_EXEC):
		os.shell_open(url)
	else:
		# Fallback option if OS feature is not available
		print("Unable to open link:", url)

func getUrlWithParams(my_list):
	# Given list
	#var my_list = ["param1", "param2", "param3"]
	var original_strings = my_list
	var unique_strings = {}
	# Count occurrences of each unique string
	for string in original_strings:
		if unique_strings.has(string):
			unique_strings[string] += 1
		else:
			unique_strings[string] = 1
	# Sort unique strings alphabetically
	var sorted_keys = unique_strings.keys()
	sorted_keys.sort()
	var result_string = ""
	# Construct new string with unique strings and their counts
	for key in sorted_keys:
		result_string += key + "=" + str(unique_strings[key]) + "&"
	# Remove the last ampersand if present
	if result_string.ends_with("&"):
		result_string = result_string.substr(0, result_string.length() - 1)
	#print("Resulting string:", result_string)
	
	# Static string
	var static_string = "https://uavcvqjflodeg6r2.anvil.app/VLLP4KHVNSV6ERKDEMMIB2K5/"
	
	# Create string starting with "?" and add list elements separated by "&"
	var query_string = "#?"
	var page_string = "page=Cart&"
	#query_string += PoolStringArray(my_list).join("&")
	query_string += page_string
	query_string += result_string
	
	# Append the resulting string to the static string
	var final_url = static_string + query_string
	
	#print("Final URL:", final_url) #debug.
	return final_url

func _pressed():
	#print("Save button pressed !!!") #debug.
	#saveGame()
	#open_link("https://andertech.dk/")
	#print(hangerList) #debug.
	var url = ""
	url = getUrlWithParams(hangerList)
	OS.shell_open(url)
	#TODO:: Reset Prolly wont work with url params - send default url or global var?
	#get_tree().reload_current_scene() 
	#get_tree().quit()

func saveGame():
	var file = File.new()
	var pathSave="user://tb_config_prop.json"
	
	file.open(pathSave, File.WRITE)
	#file.store_var(to_json(data), true)
	file.store_line(JSON.print(hangerList))
	file.close()
	pass;
