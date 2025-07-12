extends Card

func apply_effects(targets:Array[Node])->void:
	var block_effect:=BlockEffect.new() #REMEBER to change script bottom right RefCounted below resource
	block_effect.amount=5
	block_effect.execute(targets)
