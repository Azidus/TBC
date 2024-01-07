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
var rng = RandomNumberGenerator.new()

func getJsHash():
	if OS.has_feature('JavaScript'):
		print("JS available!")
		#my_label.text = " helloJS" #debug.
		var web_hash = JavaScript.eval("window.location.hash")
		#var web_hash = JavaScript.eval("window.location.href")
		if web_hash:
			print("Hash ", web_hash)
			#my_label.text = web_hash
			return web_hash
	else:
		print("The JavaScript singleton is NOT available")
		return ""

func splitIntoItemDicts(input_string):
	var parts = input_string.split("=")
	
	# Initializing dictionary
	var result_dict = {}
	
	if parts.size() == 2:
		var key = parts[0]#.strip("'")  # Extracting and cleaning the key.
		var values = parts[1].split(";")  # Splitting values by semicolon.
		
		# Constructing the dictionary with specific key-value pairs.
		result_dict["id"] = key
		result_dict["qty"] = values[0]
		result_dict["maxwidth"] = values[1]
		result_dict["maxheight"] = values[2]
		#print(result_dict)
		return result_dict
				
func getUrlParams(input_string):
	#var input_string = "example?param1=value1&param2=value2&param3=value3"

	# Find the position of the question mark
	var question_mark_position = input_string.find("?")

	if question_mark_position > -1:
		# Extract the substring after the question mark
		var params_string = input_string.substr(question_mark_position + 1)
		
		# Split the substring into a list using ampersand as the separator
		var params_list = params_string.split("&")
		
		var param_dicts = []
		for item in params_list:
			param_dicts.append(splitIntoItemDicts(item))
		# Print the resulting list
		#print(params_list)
		return param_dicts#params_list
	else:
		print("No question mark found in the input string.")
		var empty_list = []
		return empty_list


func _ready():
	var web_hash = ""
	var params_list = []
	web_hash = getJsHash()
	#web_hash = "?3D00057=1;77;252&3D00059=1;101;180&3D00061=3;104;187&3D00058=2;107;320&3D00054=2;67;389&3D00062=2;99;234&3D00056=3;60;287"
	params_list = getUrlParams(web_hash)
	load_data = params_list
	#load_game()
	#print(load_data["breastplate"]["name"])
	#var my_random_number = rng.randf_range(-1.0, 15)
	for item in load_data:
		for i in range(item['qty']):
			pickup_item(item['id'].to_upper(), [item['maxwidth'].to_int(), item['maxheight'].to_int()])

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
		pickup_item("3D00054", [0,0])
	elif c==listItem2:
		pickup_item("3D00055", [0,0])
	elif c==listItem3:
		pickup_item("3D00056", [0,0])
	elif c==listItem4:
		pickup_item("3D00057", [0,0])
	elif c==listItem5:
		pickup_item("3D00058", [0,0])
	elif c==listItem6:
		pickup_item("3D00059", [0,0])
	elif c==listItem7:
		pickup_item("3D00060", [0,0])
	elif c==listItem8:
		pickup_item("3D00061", [0,0])
	elif c==listItem9:
		pickup_item("3D00062", [0,0])
	elif c==listItem10:
		pickup_item("3D00063", [0,0])
	elif c==listItem11:
		pickup_item("3D00064", [0,0])
	elif c==listItem12:
		pickup_item("3D00065", [0,0])
	elif c==listItem13:
		pickup_item("3D00089", [0,0])
	elif c==listItem14:
		pickup_item("3D00090", [0,0])
	elif c==listItem15:
		pickup_item("3D00091", [0,0])

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

		
func pickup_item(item_id, boxDim):
	var item = item_base.instance()
	item.set_meta("id", item_id)
	#var rectText = createTexture(34, 68)
	var width = boxDim[0]
	var height = boxDim[1]
	var rectText = overLayImages(item_id, [width,height])
	#item.texture = load(ItemDb.get_item(item_id)["icon"])
	item.texture = rectText
	#item.modulate.a = 0.5
	add_child(item)
	itemCnt+=1
	sBtn.hangerList.append(item_id)
	#print(sBtn.hangerList)
	if !grid_bkpk.insert_item_at_first_available_spot(item):
		item.queue_free()
		return false
	return true
	
func pickup_items(item_id):
	var item = item_base.instance()
	item.set_meta("id", item_id)
	item.texture = load(ItemDb.get_item(item_id)["icon"])
	add_child(item)
	itemCnt+=1
	sBtn.hangerList.append(item_id)
	#print(sBtn.hangerList)
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
	
func createTexture(width,height,color=[0.5,1,0.8,1], transparency=false):
	var imageTexture = ImageTexture.new()
	var dynImage = Image.new()
	dynImage.create(width, height, false, Image.FORMAT_RGB8)
	
	if transparency:
		dynImage.fill(Color8(int(color[0]),int(color[1]),int(color[2]),0))
	else:
		dynImage.fill(Color8(int(color[0]),int(color[1]),int(color[2]),255))
	imageTexture.create_from_image(dynImage)
	var texture
	texture = imageTexture
	
	imageTexture.resource_name = "The created texture!"
	#pass
	return dynImage

func overLayImages(item_id, BG_size):
	if BG_size[0]>0 and BG_size[1]>0:
		#var imagePath = ItemDb.get_item(item_id)["icon_nobg"]
		#var image_fg = Image.new()  # Create Image for background image
		#image_fg.texture = load(ItemDb.get_item(item_id)["icon"])
		#image_fg.load(imagePath)
		var item = item_base.instance()
		item.texture = load(ItemDb.get_item(item_id)["icon_nobg"])
		var image_fg: Image = item.texture.get_data()
		
		var maxWidth = ceil(float(BG_size[0]) / grid_bkpk.cell_size) * grid_bkpk.cell_size
		var maxHeight = ceil(float(BG_size[1]) / grid_bkpk.cell_size) * grid_bkpk.cell_size
		var color = [0,0,0,0]
		var vectorX = 0
		var vectorY = 0
		var returnArray = toolSelectorSwitchCase(item_id)
		color = returnArray[0]
		vectorX = returnArray[1]
		vectorY = returnArray[2]
		var BG_texture = createTexture(maxWidth, maxHeight, color)
		# Blit the foreground image onto the background texture
		BG_texture.lock()
		var centerX = int((max(maxWidth,image_fg.get_width())/2)-(min(maxWidth,image_fg.get_width())/2))
		var yOffset = 11
		if vectorY > 0:
			yOffset *= -1
		var posY = vectorY*(maxHeight-image_fg.get_height())+yOffset
		BG_texture.blit_rect(image_fg, Rect2(0, 0, image_fg.get_width(), image_fg.get_height()), Vector2(centerX, posY))
		#BG_texture.blit_rect(image_fg, Rect2(0, 0, BG_size[0], BG_size[1]), Vector2(0, 0))
		BG_texture.unlock()	
		var imageTexture = ImageTexture.new()
		imageTexture.create_from_image(BG_texture)
		var texture
		texture = imageTexture
		return texture
	else:
		var item = item_base.instance()
		item.texture = load(ItemDb.get_item(item_id)["icon"])
		return item.texture
		
func toolSelectorSwitchCase(item_id):
	var color = [0,0,0,0]
	var vectorX = 0
	var vectorY = 0
	match item_id:
		"3D00054":
			print("3d00054 - pipewrench")
			color = [72, 249, 10, 0]
			vectorX = 0.5
			vectorY = 0
		"3D00055":
			print("3d00055 - NA")
		"3D00056":
			print("3d00056 - wrench")
			color = [255, 112, 31, 0]
			vectorX = 0.5
			vectorY = 0
		"3D00057":
			print("3d00057 - caliper")
			color = [0, 212, 187, 0]
			vectorX = 0.5
			vectorY = 1
		"3D00058":
			print("3d00058 - hammer")
			color = [255, 56, 56, 0]
			vectorX = 0.5
			vectorY = 0
		"3D00059":
			print("3d00059 - screwdriver")
			color = [255, 157, 151, 0]
			vectorX = 0.5
			vectorY = 1
		"3D00060":
			print("3d00060 - NA")
		"3D00061":
			print("3d00061 - pliers")
			color = [255, 178, 29, 0]
			vectorX = 0.5
			vectorY = 1
		"3D00062":
			print("3d00062 - spatula")
			color = [61, 219, 134, 0]
			vectorX = 0.5
			vectorY = 0
		"3D00063":
			print("3d00063 - NA")
		"3D00064":
			print("3d00064 - hexkeys")
			color = [146, 204, 23, 0]
			vectorX = 0.5
			vectorY = 1
		"3D00065":
			print("3d00065 - NA")
		"3D00089":
			print("3d00089 - NA")
		"3D00090":
			print("3d00090 - NA")
		"3D00091":
			print("3d00091 - NA")
		_:
			print("Error - unknown item id !")
	return [color, vectorX, vectorY]
