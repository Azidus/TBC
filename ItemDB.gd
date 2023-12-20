extends Node

const ICON_PATH = "res://sprites/"
const ITEMS = {
	"3D00054": {
		"name": "smallhook",
		"icon": ICON_PATH + "3D00054.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00054.jpg",
		"sortPriority": 0
	},
	"3D00055": {
		"name": "mediumhook",
		"icon": ICON_PATH + "3D00055.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00055.jpg",
		"sortPriority": 0
	},
	"3D00056": {
		"name": "largehook",
		"icon": ICON_PATH + "3D00056.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00056.jpg",
		"sortPriority": 0
	},
	"3D00057": {
		"name": "calliperholder",
		"icon": ICON_PATH + "3D00057.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00057.jpg",
		"sortPriority": 1
	},
	"3D00058": {
		"name": "doublehook",
		"icon": ICON_PATH + "3D00058.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00058.jpg",
		"sortPriority": 0
	},
	"3D00059": {
		"name": "screwdriverholder",
		"icon": ICON_PATH + "3D00059.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00059.jpg",
		"sortPriority": 1
	},
	"3D00060": {
		"name": "largestoragetray",
		"icon": ICON_PATH + "3D00060.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00060.jpg",
		"sortPriority": 1
	},
	"3D00061": {
		"name": "rulerholder",
		"icon": ICON_PATH + "3D00061.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00061.jpg",
		"sortPriority": 1
	},
	"3D00062": {
		"name": "narrowhook",
		"icon": ICON_PATH + "3D00062.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00062.jpg",
		"sortPriority": 0
	},
	"3D00063": {
		"name": "daaseholder",
		"icon": ICON_PATH + "3D00063.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00063.jpg",
		"sortPriority": 1
	},
	"3D00064": {
		"name": "unbracoholder",
		"icon": ICON_PATH + "3D00064.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00064.jpg",
		"sortPriority": 1
	},
	"3D00065": {
		"name": "multihook_s",
		"icon": ICON_PATH + "3D00065.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00065.jpg",
		"sortPriority": 0
	},
	"3D00089": {
		"name": "rulerholder_s",
		"icon": ICON_PATH + "3D00089.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00089.jpg",
		"sortPriority": 1
	},
	"3D00090": {
		"name": "multihook_m",
		"icon": ICON_PATH + "3D00090.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00090.jpg",
		"sortPriority": 0
	},
	"3D00091": {
		"name": "multihook_l",
		"icon": ICON_PATH + "3D00091.png",
		"icon_nobg": ICON_PATH + "nobg/" + "3D00091.jpg",
		"sortPriority": 0
	},
	"error": {
		"name": "error",
		"icon": ICON_PATH + "error2.png",
		"icon_nobg":  ICON_PATH + "error2.png",
		"sortPriority": 0
	}
}

func get_item(item_id):
	if item_id in ITEMS:
		return ITEMS[item_id]
	else:
		return ITEMS["error"]
