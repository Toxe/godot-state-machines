extends GuardState

@export var idle_state: State = null


func animation_finished(_anim_name: StringName) -> void:
    state_machine.transition_to(idle_state)
