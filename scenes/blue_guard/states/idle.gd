extends State

@export var walk_state: State = null


func _ready() -> void:
    assert(walk_state != null)


func process(_delta: float) -> State:
    return walk_state
