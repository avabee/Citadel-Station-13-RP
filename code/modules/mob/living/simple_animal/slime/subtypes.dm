// Tier 1

/mob/living/simple_animal/slime/purple
	desc = "This slime is rather toxic to handle, as it is poisonous."
	color = "#CC23FF"
	slime_color = list("purple" = 1)
	coretype = list(/obj/item/slime_extract/purple)
	reagents_injected = list("toxin")
	favorite_food = list("poison berry" = 1)

	description_info = "This slime spreads a toxin when it attacks.  A biosuit or other thick armor can protect from the toxic attack."

/obj/item/slime_extract/purple/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["purple"])
		return 0
	S.desc += "\nThis slime is rather toxic to handle, as it is poisonous."
	S.color = BlendRGB(S.color, "#CC23FF", 0.5)
	S.coretype += /obj/item/slime_extract/purple
	S.slime_color["purple"] = 1
	if(!LAZYLEN(S.reagents_injected))
		S.reagents_injected = list()
	S.reagents_injected += "toxin"
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food += list("poison berry")
	S.description_info += "\nThis slime spreads a toxin when it attacks.  A biosuit or other thick armor can protect from the toxic attack."

/mob/living/simple_animal/slime/orange
	desc = "This slime is known to be flammable and can ignite enemies."
	color = "#FFA723"
	slime_color = list("orange" = 1)
	coretype = list(/obj/item/slime_extract/orange)
	favorite_food = list("chili" = 1)

	description_info = "Attacks from this slime can ignite you.  A firesuit can protect from the burning attacks of this slime."

/obj/item/slime_extract/orange/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["orange"])
		return 0
	S.desc += "\nThis slime is known to be flammable and can ignite enemies."
	S.color = BlendRGB(S.color, "#FFA723", 0.5)
	S.coretype += /obj/item/slime_extract/orange
	S.slime_color["orange"] = 1
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["chili"] = 1
	S.description_info += "\nAttacks from this slime can ignite you.  A firesuit can protect from the burning attacks of this slime."

/mob/living/simple_animal/slime/orange/post_attack(mob/living/L, intent)
	if(intent != I_HELP)
		L.adjust_fire_stacks(1)
		if(prob(25))
			L.IgniteMob()
	..()

/mob/living/simple_animal/slime/blue
	desc = "This slime produces 'cryotoxin' and uses it against their foes.  Very deadly to other slimes."
	color = "#19FFFF"
	slime_color = list("blue" = 1)
	coretype = list(/obj/item/slime_extract/blue)
	reagents_injected = list("cryotoxin")
	favorite_food = list("icechili" = 1)

	description_info = "Attacks from this slime can chill you.  A biosuit or other thick armor can protect from the chilling attack."

/obj/item/slime_extract/blue/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["blue"])
		return 0
	S.desc += "\nThis slime produces 'cryotoxin' and uses it against their foes.  Very deadly to other slimes."
	S.color = BlendRGB(S.color, "#19FFFF", 0.5)
	S.coretype += /obj/item/slime_extract/blue
	S.slime_color["blue"] = 1
	if(!LAZYLEN(S.reagents_injected))
		S.reagents_injected = list()
	S.reagents_injected += "cryotoxin"
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["icechili"] = 1
	S.description_info += "\nAttacks from this slime can chill you.  A biosuit or other thick armor can protect from the chilling attack."

/mob/living/simple_animal/slime/metal
	desc = "This slime is a lot more resilient than the others, due to having a metamorphic metallic and sloped surface."
	color = "#5F5F5F"
	slime_color = list("metal" = 1)
	shiny = 1
	coretype = list(/obj/item/slime_extract/metal)
	favorite_food = list("plastellium" = 1)

	description_info = "This slime is a lot more durable and tough to damage than the others."

	resistance = 10 // Sloped armor is strong.
	maxHealth = 250

/obj/item/slime_extract/metal/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["metal"])
		return 0
	S.desc += "\nThis slime is a lot more resilient than the others, due to having a metamorphic metallic and sloped surface."
	S.color = BlendRGB(S.color, "#5F5F5F", 0.5)
	S.coretype += /obj/item/slime_extract/metal
	S.slime_color["metal"] = 1
	S.description_info += "\nThis slime is a lot more durable and tough to damage than the others."
	S.resistance += 10
	S.maxHealth += 250
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["plastellium"] = 1

// Tier 2

/mob/living/simple_animal/slime/yellow
	desc = "This slime is very conductive, and is known to use electricity as a means of defense moreso than usual for slimes."
	color = "#FFF423"
	slime_color = list("yellow" = 1)
	coretype = list(/obj/item/slime_extract/yellow)
	favorite_food = list("lemon" = 1)  // zippity zap

	ranged = 1
	shoot_range = 3
	firing_lines = 1
	projectiletype = /obj/item/projectile/beam/lightning/slime
	projectilesound = 'sound/weapons/gauss_shoot.ogg' // Closest thing to a 'thunderstrike' sound we have.
	glows = TRUE

	description_info = "This slime will fire lightning attacks at enemies if they are at range, and generate electricity \
	for their stun attack faster than usual.  Insulative or reflective armor can protect from the lightning."

/obj/item/slime_extract/yellow/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["yellow"])
		return 0
	S.desc += "\nThis slime is very conductive, and is known to use electricity as a means of defense moreso than usual for slimes."
	S.color = BlendRGB(S.color, "#FFF423", 0.5)
	S.coretype += /obj/item/slime_extract/yellow
	S.slime_color["yellow"] = 1
	S.description_info += "\nThis slime will fire lightning attacks at enemies if they are at range, and generate electricity \
	for their stun attack faster than usual.  Insulative or reflective armor can protect from the lightning."
	S.ranged = 1
	S.shoot_range = 3
	S.firing_lines = 1
	S.projectiletype = /obj/item/projectile/beam/lightning/slime
	S.projectilesound = 'sound/weapons/gauss_shoot.ogg'
	S.glows = TRUE
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["lemon"] = 1

/obj/item/projectile/beam/lightning/slime
	power = 1 // not very dangerous, just a hazard

/mob/living/simple_animal/slime/yellow/ClosestDistance() // Needed or else they won't eat monkeys outside of melee range.
	if(target_mob && ishuman(target_mob))
		var/mob/living/carbon/human/H = target_mob
		if(istype(H.species, /datum/species/monkey))
			return 1
	return ..()


/mob/living/simple_animal/slime/dark_purple
	desc = "This slime produces ever-coveted phoron. Risky to handle but very much worth it."
	color = "#660088"
	slime_color = "dark purple"
	coretype = list(/obj/item/slime_extract/dark_purple)
	reagents_injected = list("phoron")
	favorite_food = list("eggplant" = 1)

	description_info = "This slime applies phoron to enemies it attacks. A biosuit or other thick armor can protect from the toxic attack.  \
	If hit with a burning attack, it will erupt in flames."

/obj/item/slime_extract/dark_purple/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if("dark purple" in S.slime_color)
		return 0
	S.desc += "\nThis slime produces ever-coveted phoron. Risky to handle but very much worth it."
	S.color = BlendRGB(S.color, "#660088", 0.5)
	S.coretype += /obj/item/slime_extract/dark_purple
	S.slime_color += "dark purple"
	if(!LAZYLEN(S.reagents_injected))
		S.reagents_injected = list()
	S.reagents_injected += "phoron"
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["eggplant"] = 1
	S.description_info += "\nThis slime applies phoron to enemies it attacks.  A biosuit or other thick armor can protect from the toxic attack."

/mob/living/simple_animal/slime/dark_purple/proc/ignite()
	visible_message("<span class='danger'>\The [src] erupts in an inferno!</span>")
	for(var/turf/simulated/target_turf in view(2, src))
		target_turf.assume_gas("phoron", 30, 1500+T0C)
		spawn(0)
			target_turf.hotspot_expose(1500+T0C, 400)
	qdel(src)

/mob/living/simple_animal/slime/dark_purple/ex_act(severity)
	log_and_message_admins("[src] ignited due to a chain reaction with an explosion.")
	ignite()

/mob/living/simple_animal/slime/dark_purple/fire_act(datum/gas_mixture/air, temperature, volume)
	log_and_message_admins("[src] ignited due to exposure to fire.")
	ignite()

/mob/living/simple_animal/slime/dark_purple/bullet_act(var/obj/item/projectile/P, var/def_zone)
	if(P.damage_type && P.damage_type == BURN && P.damage) // Most bullets won't trigger the explosion, as a mercy towards Security.
		log_and_message_admins("[src] ignited due to being hit by a burning projectile[P.firer ? " by [key_name(P.firer)]" : ""].")
		ignite()
	else
		..()

/mob/living/simple_animal/slime/dark_purple/attackby(var/obj/item/weapon/W, var/mob/user)
	if(istype(W) && W.force && W.damtype == BURN)
		log_and_message_admins("[src] ignited due to being hit with a burning weapon ([W]) by [key_name(user)].")
		ignite()
	else
		..()




/mob/living/simple_animal/slime/dark_blue
	desc = "This slime makes other entities near it feel much colder, and is more resilient to the cold.  It tends to kill other slimes rather quickly."
	color = "#2398FF"
	glows = TRUE
	slime_color = "dark blue"
	coretype = list(/obj/item/slime_extract/dark_blue)
	favorite_food = list("icechili" = 1)

	description_info = "This slime is immune to the cold, however water will still kill it.  A winter coat or other cold-resistant clothing can protect from the chilling aura."

	minbodytemp = 0
	cold_damage_per_tick = 0

/obj/item/slime_extract/dark_blue/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if("dark blue" in S.slime_color)
		return 0
	S.desc += "\nThis slime is more resilient to the cold."
	S.color = BlendRGB(S.color, "#2398FF", 0.5)
	S.coretype += /obj/item/slime_extract/dark_blue
	S.slime_color += "dark blue"
	S.description_info += "\nThis slime is immune to the cold, however water will still kill it."
	S.glows = TRUE
	S.minbodytemp = 0
	S.cold_damage_per_tick = 0
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["icechili"] = 1

/mob/living/simple_animal/slime/dark_blue/Life()
	if(stat != DEAD)
		cold_aura()
	..()

/mob/living/simple_animal/slime/dark_blue/proc/cold_aura()
	for(var/mob/living/L in view(2, src))
		var/protection = L.get_cold_protection()

		if(protection < 1)
			var/cold_factor = abs(protection - 1)
			var/delta = -20
			delta *= cold_factor
			L.bodytemperature = max(50, L.bodytemperature + delta)
	var/turf/T = get_turf(src)
	var/datum/gas_mixture/env = T.return_air()
	if(env)
		env.add_thermal_energy(-10 * 1000)

/mob/living/simple_animal/slime/dark_blue/get_cold_protection()
	return 1 // This slime is immune to cold.

// Surface variant
/mob/living/simple_animal/slime/dark_blue/feral
	name = "feral slime"
	desc = "The result of slimes escaping containment from some xenobiology lab. The slime makes other entities near it feel much colder, \
	and it is more resilient to the cold. These qualities have made this color of slime able to thrive on a harsh, cold world and is able to rival \
	the ferocity of other apex predators in this region of Sif. As such, it is a very invasive species."
	description_info = "This slime makes other entities near it feel much colder, and is more resilient to the cold. It also has learned advanced combat tactics from \
	having to endure the harsh world outside its lab. Note that processing this large slime will give six cores."
	icon_scale = 2
	optimal_combat = TRUE // Gotta be sharp to survive out there.
	rabid = TRUE
	maxHealth = 150
	type_on_death = /mob/living/simple_animal/slime/dark_blue // Otherwise infinite slimes might occur.
	pixel_y = -10 // Since the base sprite isn't centered properly, the pixel auto-adjustment needs some help.

/mob/living/simple_animal/slime/silver
	desc = "This slime is shiny, and can deflect lasers or other energy weapons directed at it."
	color = "#AAAAAA"
	slime_color = list("silver" = 1)
	coretype = list(/obj/item/slime_extract/silver)
	shiny = TRUE
	carnivore = 1
	favorite_food = list("synthetic meat" = 1)

	description_info = "Tasers, including the slime version, are ineffective against this slime.  The slimebation still works."

/obj/item/slime_extract/silver/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["silver"])
		return 0
	S.desc += "\nThis slime is shiny."
	S.color = BlendRGB(S.color, "#AAAAAA", 0.5)
	S.coretype += /obj/item/slime_extract/silver
	S.slime_color["silver"] = 1
	S.carnivore += 1
	S.carnivore = max(S.carnivore, 2)
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food += list("synthetic meat")

/mob/living/simple_animal/slime/silver/bullet_act(var/obj/item/projectile/P, var/def_zone)
	if(istype(P,/obj/item/projectile/beam) || istype(P, /obj/item/projectile/energy))
		visible_message("<span class='danger'>\The [src] reflects \the [P]!</span>")

		// Find a turf near or on the original location to bounce to
		var/new_x = P.starting.x + pick(0, 0, 0, -1, 1, -2, 2)
		var/new_y = P.starting.y + pick(0, 0, 0, -1, 1, -2, 2)
		var/turf/curloc = get_turf(src)

		// redirect the projectile
		P.redirect(new_x, new_y, curloc, src)
		return PROJECTILE_CONTINUE // complete projectile permutation
	else
		..()


// Tier 3

/mob/living/simple_animal/slime/bluespace
	desc = "Trapping this slime in a cell is generally futile, as it can teleport at will."
	color = null
	slime_color = list("bluespace" = 1)
	icon_state_override = "bluespace"
	coretype = list(/obj/item/slime_extract/bluespace)
	favorite_food = list("bluespace tomato" = 1)

	description_info = "This slime will teleport to attack something if it is within a range of seven tiles.  The teleport has a cooldown of five seconds."

	spattack_prob = 100
	spattack_min_range = 3
	spattack_max_range = 7
	var/last_tele = null // Uses world.time
	var/tele_cooldown = 5 SECONDS

/obj/item/slime_extract/bluespace/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["bluespace"])
		return 0
	S.desc += "\nThis slime is magic, or something."
	S.color = BlendRGB(S.color, "#FFFFFF", 0.5)
	S.coretype += /obj/item/slime_extract/bluespace
	S.slime_color["bluespace"] = 1
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food += list("bluespace tomato")

/mob/living/simple_animal/slime/bluespace/ClosestDistance() // Needed or the SA AI won't ever try to teleport.
	if(world.time > last_tele + tele_cooldown)
		return spattack_max_range - 1
	return ..()

/mob/living/simple_animal/slime/bluespace/SpecialAtkTarget()
	// Teleport attack.
	if(!target_mob)
		to_chat(src, "<span class='warning'>There's nothing to teleport to.</span>")
		return FALSE

	if(world.time < last_tele + tele_cooldown)
		to_chat(src, "<span class='warning'>You can't teleport right now, wait a few seconds.</span>")
		return FALSE

	var/list/nearby_things = range(1, target_mob)
	var/list/valid_turfs = list()

	// All this work to just go to a non-dense tile.
	for(var/turf/potential_turf in nearby_things)
		var/valid_turf = TRUE
		if(potential_turf.density)
			continue
		for(var/atom/movable/AM in potential_turf)
			if(AM.density)
				valid_turf = FALSE
		if(valid_turf)
			valid_turfs.Add(potential_turf)



	var/turf/T = get_turf(src)
	var/turf/target_turf = pick(valid_turfs)

	if(!target_turf)
		to_chat(src, "<span class='warning'>There wasn't an unoccupied spot to teleport to.</span>")
		return FALSE

	var/datum/effect/effect/system/spark_spread/s1 = new /datum/effect/effect/system/spark_spread
	s1.set_up(5, 1, T)
	var/datum/effect/effect/system/spark_spread/s2 = new /datum/effect/effect/system/spark_spread
	s2.set_up(5, 1, target_turf)


	T.visible_message("<span class='notice'>\The [src] vanishes!</span>")
	s1.start()

	forceMove(target_turf)
	playsound(target_turf, 'sound/effects/phasein.ogg', 50, 1)
	to_chat(src, "<span class='notice'>You teleport to \the [target_turf].</span>")

	target_turf.visible_message("<span class='warning'>\The [src] appears!</span>")
	s2.start()

	last_tele = world.time

	if(Adjacent(target_mob))
		PunchTarget()
	return TRUE

/mob/living/simple_animal/slime/ruby
	desc = "This slime has great physical strength."
	color = "#FF3333"
	slime_color = list("ruby" = 1)
	shiny = TRUE
	glows = TRUE
	coretype = list(/obj/item/slime_extract/ruby)
	favorite_food = list("chicken" = 1)

	description_info = "This slime is unnaturally stronger, allowing it to hit much harder, take less damage, and be stunned for less time.  \
	Their glomp attacks also send the victim flying."

/obj/item/slime_extract/ruby/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["ruby"])
		return 0
	S.desc += "\nThis slime has great physical strength."
	S.color = BlendRGB(S.color, "#FF3333", 0.5)
	S.coretype += /obj/item/slime_extract/ruby
	S.slime_color["ruby"] = 1
	S.add_modifier(/datum/modifier/slime_strength, null, src)
	S.description_info = "\nThis slime is unnaturally stronger, allowing it to hit much harder, take less damage, and be stunned for less time."
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["chicken"] = 1

/mob/living/simple_animal/slime/ruby/New()
	..()
	add_modifier(/datum/modifier/slime_strength, null, src) // Slime is always swole.

/mob/living/simple_animal/slime/ruby/DoPunch(var/mob/living/L)
	..() // Do regular attacks.

	if(istype(L))
		if(a_intent == I_HURT)
			visible_message("<span class='danger'>\The [src] sends \the [L] flying with the impact!</span>")
			playsound(src, "punch", 50, 1)
			L.Weaken(1)
			var/throwdir = get_dir(src, L)
			L.throw_at(get_edge_target_turf(L, throwdir), 3, 1, src)


/mob/living/simple_animal/slime/amber
	desc = "This slime seems to be an expert in the culinary arts, as they create their own food to share with others.  \
	They would probably be very important to other slimes, if the other colors didn't try to kill them."
	color = "#FFBB00"
	slime_color = list("amber" = 1)
	shiny = TRUE
	glows = TRUE
	coretype = list(/obj/item/slime_extract/amber)
	favorite_food = list("orange" = 1)

	description_info = "This slime feeds nearby entities passively while it is alive.  This can cause uncontrollable \
	slime growth and reproduction if not kept in check.  The amber slime cannot feed itself, but can be fed by other amber slimes."

/obj/item/slime_extract/amber/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["amber"])
		return 0
	S.desc += "\nThis slime shines and glows."
	S.color = BlendRGB(S.color, "#FFBB00", 0.5)
	S.coretype += /obj/item/slime_extract/amber
	S.slime_color["amber"] = 1
	S.shiny = TRUE
	S.glows = TRUE
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["orange"] = 1

/mob/living/simple_animal/slime/amber/Life()
	if(stat != DEAD)
		feed_aura()
	..()

/mob/living/simple_animal/slime/amber/proc/feed_aura()
	for(var/mob/living/L in view(2, src))
		if(L == src) // Don't feed themselves, or it is impossible to stop infinite slimes without killing all of the ambers.
			continue
		if(isslime(L))
			var/mob/living/simple_animal/slime/S = L
			S.adjust_nutrition(rand(15, 25))
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			if(H.isSynthetic())
				continue
			H.nutrition = between(0, H.nutrition + rand(15, 25), 600)



/mob/living/simple_animal/slime/cerulean
	desc = "This slime is generally superior in a wide range of attributes, compared to the common slime.  The jack of all trades, but master of none."
	color = "#4F7EAA"
	slime_color = list("cerulean" = 1)
	coretype = list(/obj/item/slime_extract/cerulean)

	// Less than the specialized slimes, but higher than the rest.
	maxHealth = 200

	melee_damage_lower = 10
	melee_damage_upper = 30

	move_to_delay = 3

	favorite_food = list("berries" = 1)

/obj/item/slime_extract/cerulean/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["cerulean"])
		return 0
	S.desc += "\nThis slime is generally superior in a wide range of attributes, compared to the common slime.  The jack of all trades, but master of none."
	S.color = BlendRGB(S.color, "#4F7EAA", 0.5)
	S.coretype += /obj/item/slime_extract/cerulean
	S.slime_color["cerulean"] = 1
	S.maxHealth += 200
	S.melee_damage_lower += 10
	S.melee_damage_lower /= 2 // average
	S.melee_damage_upper += 30
	S.melee_damage_upper /= 2 // average
	S.move_to_delay += 3
	S.move_to_delay /= 2
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["berries"] = 1

// Tier 4

/mob/living/simple_animal/slime/red
	desc = "This slime is full of energy, and very aggressive.  'The red ones go faster.' seems to apply here."
	color = "#FF3333"
	slime_color = list("red" = 1)
	coretype = list(/obj/item/slime_extract/red)
	move_to_delay = 3 // The red ones go faster.

	description_info = "This slime is faster than the others."

	carnivore = 1
	favorite_food = list("Corgi meat" = 1)

/obj/item/slime_extract/red/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["red"])
		return 0
	S.desc += "\nThis slime is full of energy, and very aggressive.  'The red ones go faster.' seems to apply here."
	S.color = BlendRGB(S.color, "#FF3333", 0.5)
	S.coretype += /obj/item/slime_extract/red
	S.slime_color["red"] = 1
	S.description_info += "\nThis slime is faster than the others."
	S.move_to_delay += 3
	S.move_to_delay /= 2
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food += list("Corgi meat") // you monster
	S.carnivore = 1 // if you go red you gotta eat meat, that's how it is

/mob/living/simple_animal/slime/red/enrage()
	..()
	add_modifier(/datum/modifier/berserk, 30 SECONDS)


/mob/living/simple_animal/slime/green
	desc = "This slime is radioactive."
	color = "#14FF20"
	slime_color = list("green" = 1)
	coretype = list(/obj/item/slime_extract/green)
	glows = TRUE
	reagents_injected = list("radium")
	var/rads = 25
	favorite_food = list("lime" = 1)

	description_info = "This slime will irradiate anything nearby passively, and will inject radium on attack.  \
	A radsuit or other thick and radiation-hardened armor can protect from this.  It will only radiate while alive."

/obj/item/slime_extract/green/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["green"])
		return 0
	S.desc += "\nThis slime is radioactive."
	S.color = BlendRGB(S.color, "#14FF20", 0.5)
	S.coretype += /obj/item/slime_extract/green
	S.glows = TRUE
	if(!LAZYLEN(S.reagents_injected))
		S.reagents_injected = list()
	S.reagents_injected += "radium"
	S.slime_color["green"] = 1
	S.description_info += "\nThis slime will inject radium on attack. A radsuit or other thick armor can protect from this."
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["lime"] = 1

/mob/living/simple_animal/slime/green/Life()
	if(stat != DEAD)
		irradiate()
	..()

/mob/living/simple_animal/slime/green/proc/irradiate()
	radiation_repository.radiate(src, rads)


/mob/living/simple_animal/slime/pink
	desc = "This slime has regenerative properties."
	color = "#FF0080"
	slime_color = list("pink" = 1)
	coretype = list(/obj/item/slime_extract/pink)
	glows = TRUE

	description_info = "This slime will passively heal nearby entities within two tiles, including itself.  It will only do this while alive."

	favorite_food = list("cacao" = 1)

/obj/item/slime_extract/pink/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["pink"])
		return 0
	S.desc += "\nThis slime glows pink."
	S.color = BlendRGB(S.color, "#FF0080", 0.5)
	S.coretype += /obj/item/slime_extract/pink
	S.slime_color["pink"] = 1
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["cacao"] = 1

/mob/living/simple_animal/slime/pink/Life()
	if(stat != DEAD)
		heal_aura()
	..()

/mob/living/simple_animal/slime/pink/proc/heal_aura()
	for(var/mob/living/L in view(src, 2))
		if(L.stat == DEAD || L == target_mob)
			continue
		L.add_modifier(/datum/modifier/slime_heal, 5 SECONDS, src)

/datum/modifier/slime_heal
	name = "slime mending"
	desc = "You feel somewhat gooy."
	mob_overlay_state = "pink_sparkles"

	on_created_text = "<span class='warning'>Twinkling spores of goo surround you.  It makes you feel healthier.</span>"
	on_expired_text = "<span class='notice'>The spores of goo have faded, although you feel much healthier than before.</span>"
	stacks = MODIFIER_STACK_EXTEND

/datum/modifier/slime_heal/tick()
	if(holder.stat == DEAD) // Required or else simple animals become immortal.
		expire()

	if(ishuman(holder)) // Robolimbs need this code sadly.
		var/mob/living/carbon/human/H = holder
		for(var/obj/item/organ/external/E in H.organs)
			var/obj/item/organ/external/O = E
			O.heal_damage(2, 2, 0, 1)
	else
		holder.adjustBruteLoss(-2)
		holder.adjustFireLoss(-2)

	holder.adjustToxLoss(-2)
	holder.adjustOxyLoss(-2)
	holder.adjustCloneLoss(-1)

/mob/living/simple_animal/slime/gold
	desc = "This slime absorbs energy, and cannot be stunned by normal means."
	color = "#EEAA00"
	shiny = TRUE
	slime_color = list("gold" = 1)
	coretype = list(/obj/item/slime_extract/gold)
	favorite_food = list("glowberry" = 1)

/obj/item/slime_extract/gold/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["gold"])
		return 0
	S.desc += "\nThis slime is shiny and gold. Won't disappear on you, so you can sell its extracts to the extract market, or something.."
	S.shiny = TRUE
	S.color = BlendRGB(S.color, "#EEAA00", 0.5)
	S.coretype += /obj/item/slime_extract/gold
	S.slime_color["gold"] = 1
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["glowberry"] = 1

/mob/living/simple_animal/slime/gold/get_description_interaction() // So it doesn't say to use a baton on them.
	return list()


// Tier 5

/mob/living/simple_animal/slime/oil
	desc = "This slime is explosive and volatile.  Smoking near it is probably a bad idea."
	color = "#333333"
	slime_color = list("oil" = 1)
	shiny = TRUE
	coretype = list(/obj/item/slime_extract/oil)

	description_info = "If this slime suffers damage from a fire or heat based source, or if it is caught inside \
	an explosion, it will explode.  Rabid oil slimes will charge at enemies, then suicide-bomb themselves.  \
	Bomb suits can protect from the explosion."

	favorite_food = list("plastellium" = 1)

/obj/item/slime_extract/oil/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["oil"])
		return 0
	S.desc += "\nThis slime is shiny and black."
	S.color = BlendRGB(S.color, "#333333", 0.5)
	S.shiny = TRUE
	S.coretype += /obj/item/slime_extract/oil
	S.slime_color["oil"] = 1
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["plastellium"] = 1

/mob/living/simple_animal/slime/oil/proc/explode()
	if(stat != DEAD)
	//	explosion(src.loc, 1, 2, 4)
		explosion(src.loc, 0, 2, 4) // A bit weaker since the suicide charger tended to gib the poor sod being targeted.
		if(src) // Delete ourselves if the explosion didn't do it.
			qdel(src)

/mob/living/simple_animal/slime/oil/post_attack(var/mob/living/L, var/intent = I_HURT)
	if(!rabid)
		return ..()
	if(intent == I_HURT || intent == I_GRAB)
		say(pick("Sacrifice...!", "Sssss...", "Boom...!"))
		sleep(2 SECOND)
		log_and_message_admins("[src] has suicide-bombed themselves while trying to kill \the [L].")
		explode()

/mob/living/simple_animal/slime/oil/ex_act(severity)
	log_and_message_admins("[src] exploded due to a chain reaction with another explosion.")
	explode()

/mob/living/simple_animal/slime/oil/fire_act(datum/gas_mixture/air, temperature, volume)
	log_and_message_admins("[src] exploded due to exposure to fire.")
	explode()

/mob/living/simple_animal/slime/oil/bullet_act(var/obj/item/projectile/P, var/def_zone)
	if(P.damage_type && P.damage_type == BURN && P.damage) // Most bullets won't trigger the explosion, as a mercy towards Security.
		log_and_message_admins("[src] exploded due to bring hit by a burning projectile[P.firer ? " by [key_name(P.firer)]" : ""].")
		explode()
	else
		..()

/mob/living/simple_animal/slime/oil/attackby(var/obj/item/weapon/W, var/mob/user)
	if(istype(W) && W.force && W.damtype == BURN)
		log_and_message_admins("[src] exploded due to being hit with a burning weapon ([W]) by [key_name(user)].")
		explode()
	else
		..()


/mob/living/simple_animal/slime/sapphire
	desc = "This slime seems a bit brighter than the rest, both figuratively and literally."
	color = "#2398FF"
	slime_color = list("sapphire" = 1)
	shiny = TRUE
	glows = TRUE
	coretype = list(/obj/item/slime_extract/sapphire)

	optimal_combat = TRUE	// Lift combat AI restrictions to look smarter.
	run_at_them = FALSE		// Use fancy A* pathing.
	astar_adjacent_proc = /turf/proc/TurfsWithAccess // Normal slimes don't care about cardinals (because BYOND) so smart slimes shouldn't as well.
	move_to_delay = 3		// A* chasing is slightly slower in terms of movement speed than regular pathing so reducing this hopefully makes up for that.

	description_info = "This slime uses more robust tactics when fighting and won't hold back, so it is dangerous to be alone \
	with one if hostile, and especially dangerous if they outnumber you."

	favorite_food = list("ambrosiadeus" = 1)

/obj/item/slime_extract/sapphire/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["sapphire"])
		return 0
	S.desc += "\nThis slime seems a bit brighter than the rest, both figuratively and literally."
	S.color = BlendRGB(S.color, "#2398FF", 0.5)
	S.shiny = TRUE
	S.glows = TRUE
	S.optimal_combat = TRUE
	S.run_at_them = FALSE
	S.astar_adjacent_proc = /turf/proc/TurfsWithAccess
	S.move_to_delay += 3
	S.move_to_delay /= 2
	S.coretype += /obj/item/slime_extract/sapphire
	S.slime_color["sapphire"] = 1
	S.description_info += "\nThis slime uses more robust tactics when fighting and won't hold back, so it is dangerous to be alone \
	with one if hostile, and especially dangerous if they outnumber you."
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["goldapple"] = 1

/mob/living/simple_animal/slime/emerald
	desc = "This slime is faster than usual, even more so than the red slimes."
	color = "#22FF22"
	shiny = TRUE
	glows = TRUE
	slime_color = list("emerald" = 1)
	coretype = list(/obj/item/slime_extract/emerald)

	description_info = "This slime will make everything around it, and itself, faster for a few seconds, if close by."
	move_to_delay = 2

	favorite_food = list("ambrosiadeus" = 1)

/obj/item/slime_extract/emerald/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if(S.slime_color["emerald"])
		return 0
	S.desc += "\nThis slime is even faster than the red ones."
	S.color = BlendRGB(S.color, "#FF3333", 0.5)
	S.coretype += /obj/item/slime_extract/emerald
	S.slime_color["emerald"] = 1
	S.description_info += "\nThis slime goes fast."

/mob/living/simple_animal/slime/emerald/Life()
	if(stat != DEAD)
		zoom_aura()
	..()

/mob/living/simple_animal/slime/emerald/proc/zoom_aura()
	for(var/mob/living/L in view(src, 2))
		if(L.stat == DEAD || L == target_mob)
			continue
		L.add_modifier(/datum/modifier/technomancer/haste, 5 SECONDS, src)

/mob/living/simple_animal/slime/light_pink
	desc = "This slime seems a lot more peaceful than the others."
	color = "#FF8888"
	slime_color = "light pink"
	coretype = list(/obj/item/slime_extract/light_pink)
	docile = TRUE
	favorite_food = list("cherries" = 1)

/obj/item/slime_extract/light_pink/apply_info(var/mob/living/simple_animal/slime/S)
	. = ..()
	if("light pink" in S.slime_color)
		return 0
	S.desc += "\nThis slime seems a lot more peaceful than the others."
	S.color = BlendRGB(S.color, "#FF8888", 0.5)
	S.coretype += /obj/item/slime_extract/light_pink
	S.slime_color += "light pink"
	S.docile = TRUE
	if(!LAZYLEN(S.favorite_food))
		S.favorite_food = list()
	S.favorite_food["cherries"] = 1

// Special
/mob/living/simple_animal/slime/rainbow
	desc = "This slime changes colors constantly."
	color = null // Only slime subtype that uses a different icon_state.
	slime_color = list("rainbow" = 1)
	coretype = list(/obj/item/slime_extract/rainbow)
	icon_state_override = "rainbow"
	ascetic = TRUE

// The RD's pet slime.
/mob/living/simple_animal/slime/rainbow/kendrick
	name = "Kendrick"
	desc = "The Research Director's pet slime.  It shifts colors constantly."
	ascetic = TRUE

/mob/living/simple_animal/slime/rainbow/kendrick/New()
	pacify()
	..()