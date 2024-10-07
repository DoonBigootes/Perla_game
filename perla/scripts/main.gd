extends Node

var game_running : bool
var game_over : bool
var scroll
var score
const scroll_speed : int = 4
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const pipe_delay : int = 100
const pipe_range : int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$Perla.reset()

func _input(event: InputEvent) -> void:
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Perla.flying:
						$Perla.jump()
					

func start_game():
	game_running = true
	$Perla.flying = true
	$Perla.jump()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
