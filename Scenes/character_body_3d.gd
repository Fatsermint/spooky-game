extends CharacterBody3D

@onready var head: Node3D = $"../Node3D"
@onready var camera: Camera3D = $"../Node3D/Camera3D"
var speed = 7
const SENSITIVITY = 0.006
const WALK_SPEED = 4
const SPRINT_SPEED = 7 
const JUMP_VELOCITY = 700
const PUSHBACK = 8
const  BOB_FREQ = 2
const BOB_AMP = 0.08
var currenvel = Vector3.ZERO
var t_bob = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _unhandled_input(event: InputEvent) -> void:
			if event is InputEventMouseMotion:
				head.rotate_y(-event.relative.x * SENSITIVITY)
				camera.rotate_x(-event.relative.y * SENSITIVITY)
				camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
			
func _physics_process(delta: float) -> void:
		
			if not is_on_floor():
				velocity += get_gravity() * delta

	# Handle jump.
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
			if Input.is_action_just_pressed("sprint") and is_on_floor():
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
		pos.x = cos(time * BOB_FREQ / 4) * BOB_AMP 
		return pos
