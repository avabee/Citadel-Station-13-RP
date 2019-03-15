/mob/living/simple_animal/slime/FindTarget()
	if(victim) // Don't worry about finding another target if we're eatting someone.
		return
	if(follow_mob && can_command(follow_mob)) // If following someone, don't attack until the leader says so, something hits you, or the leader is no longer worthy.
		return
	..()

/mob/living/simple_animal/slime/Found(mob/living/L)
	if(isliving(L))
		if(SA_attackable(L))
			if(L.faction == faction && !attack_same)
				if(ishuman(L))
					var/mob/living/carbon/human/H = L
					if(istype(H.species, /datum/species/monkey)) // istype() is so they'll eat the alien monkeys too.
						return H // Monkeys are always food.
					else
						return

			if(!rabid) // new slimes only attack when rabid from hunger
				return

			if(ishuman(L))
				var/mob/living/carbon/human/H = L
				if(istype(H.species, /datum/species/monkey)) // istype() is so they'll eat the alien monkeys too.
					return H // Monkeys are always food.
			return
	return

/mob/living/simple_animal/slime/handle_stance(var/new_stance)
	. = ..()
	switch(stance)
		if(STANCE_IDLE)
			hunt_objects() // do slimey things!

/mob/living/simple_animal/slime/proc/eat_food(var/obj/item/weapon/reagent_containers/food/snacks/nom)
	var/yield = 0
	if(!nom)
		return // no food
	var/tag
	if(istype(nom, /obj/item/weapon/reagent_containers/food/snacks/grown))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/veg = nom
		tag = veg.seed.kitchen_tag
	else if(istype(nom, /obj/item/weapon/reagent_containers/food/snacks/meat))
		tag = initial(nom.name)
	world << LAZYLEN(favorite_food)
	world << tag
	world << favorite_food[tag]
	if(LAZYLEN(favorite_food) && tag && (favorite_food[tag]))
		yield = 2 // we love this food!
	yield = 1 // we eat this
	src.visible_message("[src] eats [nom][yield == 2 ? " and lets out a happy noise!":""].", "You eat [nom][yield == 2 ? " and it tastes amazing!":""].", "You hear the sound of something being absorbed into slime.")
	var/i
	for(i=1, i<=yield, i++)
		for(var/extract in coretype)
			var/obj/item/slime_extract/SE = new extract(loc)
			src.visible_message("[src] releases [yield] [SE]s.", "You release [yield] [SE].", "You hear a slime moving.")
	nutrition = between(nutrition, nutrition + (200 * yield), get_max_nutrition()) // they like it because they're evolutionarily adapted to eat them
	qdel(nom)

/mob/living/simple_animal/slime/proc/hunt_objects()
	if(!ascetic) // rainbow slimes don't eat atm, because i need to rebalance their extracts
		var/nom = find_food(view())
		if(nom && !Adjacent(nom))
			WanderTowards(nom.loc)
			eat_food(nom)
	if(islarge)
		return 0
	var/obj/slime_extract/SE = find_extract(view())
	if(!SE)
		return 0
	merge_extract(SE)
	return 1


/mob/living/simple_animal/slime/proc/find_extract(var/where)
	var/obj/item/slime_extract/SE = locate() in where
	return SE

/mob/living/simple_animal/slime/proc/find_food(var/where)
	var/obj/item/weapon/reagent_containers/food/snacks/nom
	if(carnivore > 0)
		nom = locate(/obj/item/weapon/reagent_containers/food/snacks/meat) in where
	if(!nom && carnivore != 1)
		nom = locate(/obj/item/weapon/reagent_containers/food/snacks/grown) in where
	return nom

/mob/living/simple_animal/slime/special_target_check(mob/living/L)
	if(L.faction == faction && !attack_same && !istype(L, /mob/living/simple_animal/slime))
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			if(istype(H.species, /datum/species/monkey)) // istype() is so they'll eat the alien monkeys too.
				return TRUE // Monkeys are always food.
			else
				return FALSE
	if(!rabid)
		return FALSE

	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.species && H.species.name == "Promethean")
			return FALSE // Prometheans are always our friends.
		else if(istype(H.species, /datum/species/monkey)) // istype() is so they'll eat the alien monkeys too.
			return TRUE // Monkeys are always food.

	return ..() // Other colors and nonslimes are jerks however.

/mob/living/simple_animal/slime/ClosestDistance()
	if(target_mob.stat == DEAD)
		return 1 // Melee (eat) the target if dead, don't shoot it.
	return ..()

/mob/living/simple_animal/slime/HelpRequested(var/mob/living/simple_animal/slime/buddy)
	if(istype(buddy))
		if(LAZYLEN(buddy.slime_color &= src.slime_color)) // We only help slimes that share colors with us, if it's another slime calling for help.
			ai_log("HelpRequested() by [buddy] but they are a [buddy.slime_color.Join(" ")] while we are a [src.slime_color.Join(" ")].",2)
			return
		if(buddy.target_mob)
			if(!special_target_check(buddy.target_mob))
				ai_log("HelpRequested() by [buddy] but special_target_check() failed when passed [buddy.target_mob].",2)
				return
	..()


/mob/living/simple_animal/slime/handle_resist()
	if(buckled && victim && isliving(buckled) && victim == buckled) // If it's buckled to a living thing it's probably eating it.
		return
	else
		..()
