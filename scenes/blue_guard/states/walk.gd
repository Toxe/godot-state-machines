extends State

@export var player_spotted_state: State = null


func _ready() -> void:
    assert(player_spotted_state != null)
