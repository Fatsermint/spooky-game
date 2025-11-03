extends CharacterBody3D
@onready var rayCast: RayCast3D = $Node3D/RayCast3D

@onready var camera: Camera3D = $Node3D/Camera3D
@onready var head: Node3D = $Node3D
var speed = 3
const SENSITIVITY = 0.003
const WALK_SPEED = 3
const SPRINT_SPEED = 3
const JUMP_VELOCITY = 3
signal win
const  BOB_FREQ = 2
const BOB_AMP = 0.08
var t_bob = 0
var onGame = false
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if onGame == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))
func _physics_process(delta: float) -> void:
	if onGame == true:
			if not is_on_floor():
				velocity += get_gravity() * delta

	# Handle jump.
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
			if Input.is_action_just_pressed("sprint") and is_on_floor():
				if speed == WALK_SPEED:
					speed = SPRINT_SPEED
				else:
					speed = WALK_SPEED
			

			var input_dir := Input.get_vector("left", "right", "up", "down")
			var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			if direction:
				velocity.x = direction.x * speed
				velocity.z = direction.z * speed
			else:
				velocity.x = 0.0
				velocity.z = 0.0
			t_bob += delta * velocity.length() * float(is_on_floor())
			camera.transform.origin = _headbob(t_bob)
			move_and_slide()

func _headbob(time) -> Vector3:

		var pos = Vector3.ZERO
		pos.y = sin(time * BOB_FREQ) * BOB_AMP
		pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP 
		return pos

var obj

@onready var ray: RayCast3D = $Node3D/RayCast3D
@onready var keys_count: Label = $"../KeysCount"
@onready var area: Area3D = $DoorFaculty/Area3D
@onready var animation: AnimationPlayer = $"../Label/AnimationPlayer"
@onready var label: Label = $"../Label"
@onready var music: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var iSeeYou: AudioStreamPlayer = $"../AudioStreamPlayer2"
@onready var timer: Timer = $"../Timer"
@onready var keysImg: TextureRect = $"../Keys"
var keys = 0
var keysNeeded = 3
var complete = false
func _process(delta):

	if onGame == true:
		if keys == 0:
			keys_count.text = "0/" + str(keysNeeded)
			if not label.text == "Don't Let That Zombie Get Close To You!":
				animation.play("text")
				label.text = "Don't Let That Zombie Get Close To You!"
		if keys == 1:
			if not label.text == "WOW! You Already Found One? Keep Going!":
				label.text = "WOW! You Already Found One? Keep Going!"
				animation.play("text")
		
		if keys == 2:
			if keysNeeded ==3:
				if not label.text == "Only One Key Left To Find!":
					label.text = "Only One Key Left To Find!"
					animation.play("text")
			else:
				if not label.text == "You can do it!":
					label.text = "You can do it!"
					animation.play("text")
		if keys == 3:
			if keysNeeded == 6:
				if not label.text == "Halfway!":
					label.text = "Halfway!"
					animation.play("text")
					
			if keysNeeded == 9:
				if not label.text == "You are 1/3 way there!":
					label.text = "You are 1/3 way there!"
					animation.play("text")
			if keysNeeded == 3 and complete == false:
				if not label.text == "Now Head To Door Where You Started From":
					label.text = "Now Head To Door Where You Started From"
					animation.play("text")
		if keys == 4:
			if keysNeeded == 6 or keysNeeded == 9:
				if not label.text == "Keep going!":
					label.text = "Keep going!"
					animation.play("text")
				
		if keys == 5:
			if keysNeeded == 6:
				if not label.text == "You have to find only one more!":
					label.text = "You have to find only one more!"
					animation.play("text")
					
			if keysNeeded == 9:
				if not label.text == "You are over halfway!":
					label.text = "You are over halfway!"
					animation.play("text")
					
		if keys == 6:
			if keysNeeded == 9:
				if not label.text == "You are true gamer!":
					label.text = "You are true gamer!"
					animation.play("text")
						
		if keys == 7:
			if keysNeeded == 9:
				if not label.text == "You can do it!!!!":
					label.text = "You can do it!!!!"
					animation.play("text")
						
		if keys == 8:
			if keysNeeded == 9:
				if not label.text == "ONE MORE!!!":
					label.text = "ONE MORE!!!"
					animation.play("text")
						
		if keys == keysNeeded and complete == false:
			if not label.text == "Now Head To Door Where You Started From":
				label.text = "Now Head To Door Where You Started From"
				animation.play("text")
				complete = true
				win.emit()
				$"../YouLost".visible = true
		if Input.is_action_just_pressed("interract"):
			print("1")
			if ray.is_colliding():
				print("2")
				obj = ray.get_collider()
				print(obj)
				if obj.get_parent().is_in_group("keys"):
					obj.get_parent().queue_free()
					keys += 1
					keys_count.text = str(keys) +"/" + str(keysNeeded)


func _on_door(body: Node3D) -> void:
	print("TOIMII")
	if onGame == true:
		print("2")
		if complete == true or keys == keysNeeded:
			print("you won")
			
			if not label.text == "You Won!":
				label.text = "You Won!"
				animation.play("text")
				music.stop()
				onGame = false
				$"../YouLost".visible = true
				win.emit()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				
func _on_starting_menu_play() -> void:
	onGame = true
	music.play()


func _on_timer_timeout() -> void:
	iSeeYou.play()
	timer.start()


func _on_video_stream_player_finished() -> void:
	onGame = false
	keys_count.visible = false
	keysImg.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_you_lost_try_again() -> void:
	get_tree().reload_current_scene()


func _on_you_lost_mainmenu() -> void:
	keys = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	


func _on_starting_menu_easy() -> void:
	keysNeeded = 3


func _on_starting_menu_normal() -> void:
	keysNeeded = 6



func _on_starting_menu_hard() -> void:
	keysNeeded = 9
