extends AnimatedSprite


func _ready():
	self.connect("animation_finished", self, "_on_animate_finished")
	frame = 0
	play("effect")
	
func _on_animate_finished():
	queue_free()
