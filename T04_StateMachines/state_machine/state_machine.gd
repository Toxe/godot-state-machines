class_name MyStateMachine extends Node

@export var initial_state: MyState = null
var current_state: MyState = null


func _ready() -> void:
    assert(initial_state != null, "%s state machine initial state is not set." % owner.name)

    for state: MyState in get_states():
        state.state_machine = self
        state.setup()

    change_state(initial_state)


func _process(delta: float) -> void:
    change_state(current_state.process(delta))


func _physics_process(delta: float) -> void:
    change_state(current_state.physics_process(delta))


func _unhandled_input(event: InputEvent) -> void:
    change_state(current_state.unhandled_input(event))


func get_states() -> Array[MyState]:
    var states: Array[MyState] = []
    for child: Node in get_children():
        if child is MyState:
            states.append(child)
    return states


func change_state(new_state: MyState) -> void:
    if new_state:
        if current_state:
            current_state.exit()

        current_state = new_state
        current_state.enter()


func transition_to(next_state: MyState) -> void:
    change_state(next_state)
