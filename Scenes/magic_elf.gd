extends Elf
@export var magiclvl := 0.4
func _ready() -> void:
	super()
	if Global.bag or Global.magic >= magiclvl:
		queue_free()
