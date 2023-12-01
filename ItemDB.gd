extends Node

const ICON_PATH = "res://sprites/"
const ITEMS = {
	"3D00054": {
		"icon": ICON_PATH + "3D00054.png"
	},
	"3D00055": {
		"icon": ICON_PATH + "3D00055.png"
	},
	"3D00056": {
		"icon": ICON_PATH + "3D00056.png"
	},
	"3D00057": {
		"icon": ICON_PATH + "3D00057.png"
	},
	"3D00058": {
		"icon": ICON_PATH + "3D00058.png"
	},
	"3D00059": {
		"icon": ICON_PATH + "3D00059.png"
	},
	"3D00060": {
		"icon": ICON_PATH + "3D00060.png"
	},
	"3D00061": {
		"icon": ICON_PATH + "3D00061.png"
	},
	"3D00062": {
		"icon": ICON_PATH + "3D00062.png"
	},
	"3D00063": {
		"icon": ICON_PATH + "3D00063.png"
	},
	"3D00064": {
		"icon": ICON_PATH + "3D00064.png"
	},
	"3D00065": {
		"icon": ICON_PATH + "3D00065.png"
	},
	"3D00089": {
		"icon": ICON_PATH + "3D00089.png"
	},
	"3D00090": {
		"icon": ICON_PATH + "3D00090.png"
	},
	"3D00091": {
		"icon": ICON_PATH + "3D00091.png"
	},
	"error": {
		"icon": ICON_PATH + "error2.png"
	}
}

func get_item(item_id):
	if item_id in ITEMS:
		return ITEMS[item_id]
	else:
		return ITEMS["error"]
