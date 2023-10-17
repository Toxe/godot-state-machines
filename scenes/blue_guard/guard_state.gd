class_name GuardState extends State

@export var animation: StringName = &""

var guard: BlueGuard = null
var player: Player = null
var animation_player: AnimationPlayer = null


func setup() -> void:
    guard = state_machine.owner as BlueGuard
    player = get_tree().get_first_node_in_group("player") as Player
    animation_player = guard.get_node("AnimationPlayer") as AnimationPlayer


func enter() -> void:
    if animation != &"":
        animation_player.play(animation)
