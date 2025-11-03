extends CharacterBody3D


var player = null
var state_machine

var ATTACK_RANGE = 1.75
var SPEED = 2.5 #2

var onGame = false
@onready var jumpscare: VideoStreamPlayer = $"../../Node2D/VideoStreamPlayer"

@export var player_path : NodePath
@onready var navigationAgent = $NavigationAgent3D
@onready var animationTree: AnimationTree = $AnimationTree
@onready var collisionshape: CollisionShape3D = $CollisionShape3D
@onready var rayCast: RayCast3D = $RayCast
@onready var jump_scare: Node2D = $"../../JumpScare"
@onready var you_lost: Control = $"../../YouLost"
@onready var infoLabel: Label = $"../../Label"



func  _ready() -> void:
		player = get_node(player_path)
		state_machine = animationTree.get("parameters/playback")
	
		


func _physics_process(delta: float) -> void:
	if onGame == true:

		match state_machine.get_current_node():

			"IDLE":
				rayCast.look_at(player.global_position, Vector3.UP)
				if rayCast.is_colliding():
					if rayCast.get_collider() == player:
						animationTree.set("parameters/conditions/WALK", true)
			"WALK":
				if onGame == true:
					velocity = Vector3.ZERO
					navigationAgent.set_target_position(player.global_position)
					var next_nav_point = navigationAgent.get_next_path_position()
					velocity = (next_nav_point - global_position).normalized() * SPEED 
					animationTree.set("parameters/conditions/ATK", target_in_range())
					look_at(Vector3(next_nav_point.x, global_position.y, next_nav_point.z), Vector3.UP)
					if target_in_range():
						animationTree.set("parameters/conditions/ATK", true)
					else:
						animationTree.set("parameters/conditions/WALK", true)
						move_and_slide()
			"ATK":
				if onGame == true:
					animationTree.set("parameters/conditions/WALK", !target_in_range())
					look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
			"DEAD":
				pass
			"HIT":
				pass

@onready var cursor: TextureRect = $"../../TextureRect"

var dir
func hit_player():
	if onGame == true:
		if target_in_range():
			if onGame == true:
				jumpscare.visible = true
				if onGame == true:
					jumpscare.play()
				cursor.visible = false
func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
	


func _on_video_stream_player_finished() -> void:
	jumpscare.visible = false
	jumpscare.stop()
	cursor.visible = false
	you_lost.visible = true
	onGame = false
	infoLabel.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_starting_menu_play() -> void:
	onGame = true


func _on_you_lost_mainmenu() -> void:
	onGame = true


func _on_starting_menu_easy() -> void:
	SPEED = 2.45
	


func _on_starting_menu_normal() -> void:
	SPEED = 2.67


func _on_starting_menu_hard() -> void:
	SPEED = 2.85


func _on_player_win() -> void:
	onGame = false
