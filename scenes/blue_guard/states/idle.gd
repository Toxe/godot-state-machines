extends GuardState

@export var walk_state: State = null


func enter() -> void:
    guard.get_node("AnimationPlayer").play("idle")


func process(_delta: float) -> State:
    return walk_state
