//////////////////
// Slime Vacuum //
//////////////////
/obj/item/weapon/slimevac
	name = "slime vacuum"
	desc = "A portable shop-vac modified to safely and humanely hold and transport slime specimens."
	icon_state = "slimebaton" // placeholder
	item_state = "slimebaton" // placeholder
	slot_flags = SLOT_BELT
	origin_tech = list(TECH_BIO = 2, TECH_POWER = 2, TECH_MAGNET = 2)
	var/max_capacity = 5 // we can hold five slimes
	var/range = 7 // grab slimes within your view distance
	var/list/slimes = list() // list of slimes

/obj/item/weapon/slimevac/afterattack(atom/A, mob/user, proximity_flag)
	var/dist = get_dist(A, user)
	if(dist > range)
		return
	if(!istype(A, /mob/living/simple_animal/slime))
		var/mob/living/simple_animal/slime/V = pick(slimes)
		slimes -= V
		V.forceMove(get_turf(src))
		V.throw_at(A, range, .1, src)
		user.visible_message("You launch [V] out of [src] at [A]!", "[user] launches [V] out of [src] at [A]!", "You hear the sound of a pneumatic launcher.")
		return
	if(LAZYLEN(slimes) >= max_capacity)
		return
	var/mob/living/simple_animal/slime/V = A
	V.throw_at(src.loc, range, .1, src)
	if(!user.Adjacent(V))
		return
	user.visible_message("You suck [V] up into [src]'s container.", "[user] sucks [V] up into [src]'s container.", "You hear the sound of something soft and wet being sucked through a small tube.")
	V.forceMove(src)
	slimes += V