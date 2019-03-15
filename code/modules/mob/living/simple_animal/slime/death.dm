/mob/living/simple_animal/slime/death(gibbed)
	if(stat == DEAD)
		return
	stop_consumption()
	. = ..(gibbed, "stops moving and partially dissolves...")
	update_icon()
	return