extends CharacterBody2D
#variables
@export var speed: float = 20.0 #velocidad horizontal
@export var fall_speed: float = 100.0
@export var slow_fall_speed: float = 0.25
@export var max_fall_speed: float = 200.0 #valor maximo de velocidad de caida
@export var gravity: float = 150 #aceleracion en y
@export var jump_strenght: float = -5000.0 #fuerza del salto (que tan alto se eleva)
var is_flying: bool = true #empieza volando, si se choca o toca suelo (false) termina la partida
var slow_fall:bool = true #tiempo que espera antes de caer aceleradamente
var slow_fall_duration: float = 0.5
@onready var slow_fall_Timer = $slow_fall_Timer

#funcion de "setup", se llama al inicializar el nodo
func _ready() -> void:
	velocity.x = speed #asigna la velocidad de movimiento horizontal
	
#funcion de fisicas, se manda a llamar cada frame
func _physics_process(delta: float) -> void:
	if is_flying && !Input.is_action_just_pressed("jump"):
		fall(delta)
	if Input.is_action_just_pressed("jump"):
		jump()
	move_and_slide()
	if is_on_floor():
		is_flying = false

#funcion para hacer caer a perla
func fall(delta):
	#si esta en slow fall, que caiga lento, de lo contrario cae normal
	if slow_fall:
		velocity.y = fall_speed * slow_fall_speed * gravity  * delta
	else:
		velocity.y = (fall_speed * gravity) * delta
		if velocity.y > max_fall_speed:
			velocity.y = max_fall_speed

#funcion para hacer "saltar" a perla
func jump():
	velocity.y = jump_strenght
	slow_fall_Timer.wait_time = slow_fall_duration
	slow_fall_Timer.start()
	slow_fall = true

#signal, un trigger que se llama cuando el timer acaba
func _on_slow_fall_timer_timeout() -> void:
	slow_fall = false
