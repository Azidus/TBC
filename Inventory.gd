extends Control

const item_base = preload("res://ItemBase.tscn") 

onready var inv_base = $InventoryBase
onready var grid_bkpk = $ToolboardGrid#$GridBackPack
onready var scroll_con = $ScrollContainer
onready var listItem1 = $ScrollContainer/VBoxContainer/listItem1
onready var listItem2 = $ScrollContainer/VBoxContainer/listItem2
onready var listItem3 = $ScrollContainer/VBoxContainer/listItem3
onready var listItem4 = $ScrollContainer/VBoxContainer/listItem4
onready var listItem5 = $ScrollContainer/VBoxContainer/listItem5
onready var listItem6 = $ScrollContainer/VBoxContainer/listItem6
onready var listItem7 = $ScrollContainer/VBoxContainer/listItem7
onready var listItem8 = $ScrollContainer/VBoxContainer/listItem8
onready var listItem9 = $ScrollContainer/VBoxContainer/listItem9
onready var listItem10 = $ScrollContainer/VBoxContainer/listItem10
onready var listItem11 = $ScrollContainer/VBoxContainer/listItem11
onready var listItem12 = $ScrollContainer/VBoxContainer/listItem12
onready var listItem13 = $ScrollContainer/VBoxContainer/listItem13
onready var listItem14 = $ScrollContainer/VBoxContainer/listItem14
onready var listItem15 = $ScrollContainer/VBoxContainer/listItem15
onready var sBtn = $saveBtn
#onready var eq_slots = $EquipmentSlots
#onready var load_data:Dictionary={}
onready var load_data = []
onready var my_label = $Label

var item_held = null
var item_offset = Vector2()
var last_container = null
var last_pos = Vector2()
var itemCnt = 0

func getJsHash():
	if OS.has_feature('JavaScript'):
		print("JS available!")
		#my_label.text = " helloJS" #debug.
		#var web_hash = JavaScript.eval("window.location.hash")
		var web_hash = JavaScript.eval("window.location.href")
		if web_hash:
			print("Hash ", web_hash)
			#my_label.text = web_hash
			return web_hash
	else:
		print("The JavaScript singleton is NOT available")
		return ""
		
func getUrlParams(input_string):
	#var input_string = "example?param1=value1&param2=value2&param3=value3"

	# Find the position of the question mark
	var question_mark_position = input_string.find("?")

	if question_mark_position > -1:
		# Extract the substring after the question mark
		var params_string = input_string.substr(question_mark_position + 1)
		
		# Split the substring into a list using ampersand as the separator
		var params_list = params_string.split("&")
		
		# Print the resulting list
		print(params_list)
		return params_list
	else:
		print("No question mark found in the input string.")
		var empty_list = []
		return empty_list


func _ready():
	var web_hash = ""
	var params_list = []
	web_hash = getJsHash()
	params_list = getUrlParams(web_hash)
	load_data = params_list
	#load_game()
	#print(load_data["breastplate"]["name"])
	#pickup_item("3D00055")
	#pickup_item("3D00056")
	#pickup_item("3D00057")
	#pickup_item("3D00058")
	#pickup_item("3D00059")
	#pickup_item("3D00060")
	#pickup_item("3D00061")
	#pickup_item("3D00062")
	#pickup_item("3D00063")
	#pickup_item("3D00064")
	#pickup_item("3D00065")
	#pickup_item("3D00089")
	#pickup_item("3D00090")
	#pickup_item("3D00091")
	#pickup_item("yomama")
	for item in load_data:
		pickup_item(item.to_lower())

func _process(delta):
	sBtn.text = "KURV (" + str(itemCnt) + ")"
	var cursor_pos = get_global_mouse_position()
	if Input.is_action_just_pressed("inv_grab"):
		grab(cursor_pos)
	if Input.is_action_just_released("inv_grab"):
		release(cursor_pos)
	if item_held != null:
		item_held.rect_global_position = cursor_pos + item_offset

func grab(cursor_pos):
	var c = get_container_under_cursor(cursor_pos) 
	#print(c)
	if c!= null and c.has_method("grab_item"):
		item_held = c.grab_item(cursor_pos)
		if item_held != null:
			last_container = c
			last_pos = item_held.rect_global_position
			item_offset = item_held.rect_global_position - cursor_pos
			move_child(item_held, get_child_count())
	elif c==listItem1:
		pickup_item("3D00054")
	elif c==listItem2:
		pickup_item("3D00055")
	elif c==listItem3:
		pickup_item("3D00056")
	elif c==listItem4:
		pickup_item("3D00057")
	elif c==listItem5:
		pickup_item("3D00058")
	elif c==listItem6:
		pickup_item("3D00059")
	elif c==listItem7:
		pickup_item("3D00060")
	elif c==listItem8:
		pickup_item("3D00061")
	elif c==listItem9:
		pickup_item("3D00062")
	elif c==listItem10:
		pickup_item("3D00063")
	elif c==listItem11:
		pickup_item("3D00064")
	elif c==listItem12:
		pickup_item("3D00065")
	elif c==listItem13:
		pickup_item("3D00089")
	elif c==listItem14:
		pickup_item("3D00090")
	elif c==listItem15:
		pickup_item("3D00091")

func release(cursor_pos):
	if item_held == null:
		return
	var c = get_container_under_cursor(cursor_pos)
	#if c == null:
	if c != grid_bkpk:
		var i = sBtn.hangerList.find(item_held.get_meta("id"))
		sBtn.hangerList.remove(i)
		drop_item()
		itemCnt-=1
	elif c.has_method("insert_item"):
		if c.insert_item(item_held):
			item_held = null
		else:
			return_item()
	else:
		return_item()
		
func get_container_under_cursor(cursor_pos):
	#var containers = [grid_bkpk, eq_slots, inv_base]
	var containers = [grid_bkpk, listItem1, listItem2, listItem3, listItem4, listItem5, listItem6, listItem7, listItem8, listItem9, listItem10, listItem11, listItem12, listItem13, listItem14, listItem15, scroll_con, inv_base]
	for c in containers:
		if c.get_global_rect().has_point(cursor_pos):
			return c
	return null
	
func drop_item():
	item_held.queue_free()
	item_held = null
	
func return_item():
	item_held.rect_global_position = last_pos
	last_container.insert_item(item_held)
	item_held = null
		
func pickup_item(item_id):
	var item = item_base.instance()
	item.set_meta("id", item_id)
	item.texture = load(ItemDb.get_item(item_id)["icon"])
	add_child(item)
	itemCnt+=1
	sBtn.hangerList.append(item_id)
	print(sBtn.hangerList)
	if !grid_bkpk.insert_item_at_first_available_spot(item):
		item.queue_free()
		return false
	return true
	
func load_game():
	# Open the JSON file for reading:
	var file = File.new()
	var pathLoad="user://tb_config_prop1.json"

	if file.file_exists(pathLoad):
		file.open(pathLoad, File.READ)
		var loadParam = parse_json(file.get_var(true));
		file.close()
		if loadParam!=null:
			load_data=loadParam;
			pass;
		else:
			print("Failed to parse JSON data.")
	else:	
		print("Save file does not exist - starting new game..")		
	pass;
