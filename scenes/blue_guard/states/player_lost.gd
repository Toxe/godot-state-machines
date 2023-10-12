extends State

@export var idle_state: State = null


func _ready() -> void:
    assert(idle_state != null)
