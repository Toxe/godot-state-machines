class_name StateMachine extends Node

@export var initial_state: State = null
var current_state: State = null


func _ready() -> void:
    assert(initial_state != null)
    change_state(initial_state)


func _process(delta: float) -> void:
    var new_state := current_state.process(delta)
    if new_state:
        change_state(new_state)


func _physics_process(delta: float) -> void:
    var new_state := current_state.physics_process(delta)
    if new_state:
        change_state(new_state)


func _unhandled_input(event: InputEvent) -> void:
    var new_state := current_state.unhandled_input(event)
    if new_state:
        change_state(new_state)


func change_state(new_state: State) -> void:
    if new_state:
        if current_state:
            current_state.exit()

        current_state = new_state
        current_state.enter()
