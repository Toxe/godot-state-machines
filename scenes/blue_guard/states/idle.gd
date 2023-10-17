extends GuardState

@export var walk_state: State = null


func process(_delta: float) -> State:
    return walk_state
