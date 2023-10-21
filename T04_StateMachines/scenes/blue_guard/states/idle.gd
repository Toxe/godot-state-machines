extends GuardState

@export var walk_state: MyState = null


func process(_delta: float) -> MyState:
    return walk_state
