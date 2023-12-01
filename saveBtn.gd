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

func _pressed():
	print("Save button pressed !!!")
	saveGame()

func saveGame():
	var file = File.new()
	var pathSave="user://tb_config_prop.json"
	
	file.open(pathSave, File.WRITE)
	#file.store_var(to_json(data), true)
	file.store_line(JSON.print(hangerList))
	file.close()
	pass;
