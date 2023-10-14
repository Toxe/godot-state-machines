extends State

@export var walk_state: State = null

var guard: BlueGuard = null


func setup(_sm: StateMachine) -> void:
    guard = owner as BlueGuard


func enter() -> void:
    guard.get_node("AnimationPlayer").play("idle")


func process(_delta: float) -> State:
    return walk_state
