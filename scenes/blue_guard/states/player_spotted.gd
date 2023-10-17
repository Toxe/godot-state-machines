extends GuardState

@export var follow_player_state: State = null


func physics_process(_delta: float) -> State:
    if not animation_player.is_playing():
        return follow_player_state

    return null
