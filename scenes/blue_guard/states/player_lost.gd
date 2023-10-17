extends GuardState

@export var idle_state: State = null


func physics_process(_delta: float) -> State:
    if not animation_player.is_playing():
        return idle_state

    return null
