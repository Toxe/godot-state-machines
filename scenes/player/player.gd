class_name Player extends CharacterBody2D

const speed := 300.0


func _physics_process(_delta: float) -> void:
    velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed
    move_and_slide()
