extends GuardState

@export var follow_player_state: MyState = null


func animation_finished(_anim_name: StringName) -> void:
    state_machine.transition_to(follow_player_state)
