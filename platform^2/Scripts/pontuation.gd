extends Control

@onready var coins_counter = $HBoxContainer/results_container/coins_container/coins_counter
@onready var timer_counter = $HBoxContainer/results_container/timer_container/timer_counter

var database : SQLite

# Called when the node enters the scene tree for the first time.
func _ready():
	coins_counter.text = str(Globals.coins)
	timer_counter.text = str("%02d" % Globals.minutes) + ":" + str("%02d" % Globals.seconds)
	
	
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
	
	#var table = {
		#"nivel" : {"data_type": "int"},
		#"segundos" : {"data_type": "int", "not_null":true},
		#"minutos" : {"data_type": "char", "not_null":true},
		#"coins" : {"data_type": "int", "not_null":true},
		#"register_username" : {"data_type": "int", "not_null":true}
	#}
	#database.create_table("scores", table)
	
	var data = {
			"nivel" : Globals.nivel,
			"segundos" : Globals.seconds,
			"coins" : Globals.coins,
			"register_username" : Globals.username,
			"minutos" : Globals.minutes
		}
		
	database.select_rows('scores', "register_username = '" + Globals.username + "' and minutos = '" + str(Globals.minutes) + "' and segundos = '" + str(Globals.seconds) + "' and nivel = '" + str(Globals.nivel) + "' and coins = '" + str(Globals.coins) + "'", ["*"])
	var query_result : Array = database.query_result
	
	if query_result.is_empty():
		database.insert_row("scores", data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_again_btn_pressed():
	if Globals.nivel == 1: 
		get_tree().change_scene_to_file("res://Cenas/nivel_1.tscn")
		
	if Globals.nivel == 2: 
		get_tree().change_scene_to_file("res://Cenas/nivel_2.tscn")
	
	if Globals.nivel == 3: 
		get_tree().change_scene_to_file("res://Cenas/nivel_3.tscn")
		
	if Globals.nivel == 4:
		get_tree().change_scene_to_file("res://Cenas/nivel_4.tscn")


func _on_quit_btn_pressed():
	get_tree().change_scene_to_file("res://Cenas/depois_login.tscn")

