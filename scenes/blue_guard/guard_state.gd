class_name GuardState extends State

var guard: BlueGuard = null
var player: Player = null


func setup(sm: StateMachine) -> void:
    guard = sm.owner as BlueGuard
    player = get_tree().get_first_node_in_group("player") as Player
