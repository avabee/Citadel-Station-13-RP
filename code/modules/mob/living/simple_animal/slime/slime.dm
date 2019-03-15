/mob/living/simple_animal/slime
	name = "slime"
	desc = "The most basic of slimes.  The grey slime has no remarkable qualities, however it remains one of the most useful colors for scientists."
	tt_desc = "A Macrolimbus vulgaris"
	icon = 'icons/mob/slime2.dmi'
	icon_state = "grey baby slime"
	intelligence_level = SA_ANIMAL
	pass_flags = PASSTABLE
	var/shiny = FALSE // If true, will add a 'shiny' overlay.
	var/glows = FALSE // If true, will glow in the same color as the color var.
	var/icon_state_override = null // Used for special slime appearances like the rainbow slime.
	pass_flags = PASSTABLE

	makes_dirt = FALSE	// Goop

	speak_emote = list("chirps")

	maxHealth = 150
	var/maxHealth_large = 200
	melee_damage_lower = 5
	melee_damage_upper = 25
	melee_miss_chance = 0
	gender = NEUTER

	// Atmos stuff.
	minbodytemp = T0C-30
	heat_damage_per_tick = 0
	cold_damage_per_tick = 40

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	unsuitable_atoms_damage = 0

	response_help = "pets"

	speak = list(
		"Blorp...",
		"Blop..."

		)
	emote_hear = list(

		)
	emote_see = list(
		"bounces",
		"jiggles",
		"sways"
		)

	hostile = 1
	retaliate = 1
	attack_same = 1
	cooperative = 1
	faction = "slime" // Slimes will help other slimes, provided they share the same color.

	color = "#CACACA"
	var/is_large = FALSE
	var/number = 0 // This is used to make the slime semi-unique for identification.

	var/mob/living/victim = null // the person the slime is currently feeding on
	var/rabid = FALSE	// If true, will attack anyone and everyone.
	var/docile = FALSE	// Basically the opposite of above.  If true, will never harm anything and won't get hungry.
	var/optimal_combat = FALSE // Used to dumb down the combat AI somewhat.  If true, the slime tends to be really dangerous to fight alone due to stunlocking.
	var/mood = ":3" // Icon to use to display 'mood'.
	var/obj/item/clothing/head/hat = null // The hat the slime may be wearing.

	var/list/slime_color = list("grey" = 1)
	var/list/coretype = list(/obj/item/slime_extract/grey)
	var/type_on_death = null // Set this if you want dying slimes to split into a specific type and not their type.

	var/list/reagents_injected = null // Some slimes inject reagents on attack.  This tells the game what reagent to use.
	var/injection_amount = 5 // This determines how much.

	var/ascetic = FALSE
	var/list/favorite_food
	var/carnivore = FALSE

	var/steroid = FALSE // to see if a slime has been 'roided

	can_enter_vent_with = list(
	/obj/item/clothing/head,
	)

/mob/living/simple_animal/slime/New(var/location, var/start_as_large = FALSE)
	verbs += /mob/living/proc/ventcrawl
	if(start_as_large)
		make_large()
	health = maxHealth
	update_icon()
	number = rand(1, 1000)
	update_name()
	..(location)

/mob/living/simple_animal/slime/Destroy()
	if(hat)
		drop_hat()
	return ..()

/mob/living/simple_animal/slime/proc/merge_extract(var/obj/item/slime_extract/SE)
	if(src.is_large)
		return // add tarrs later, but for now return
	if(!istype(SE))
		return
	if(!SE.apply_info(src))
		return
	world << color
	src.make_large()

/mob/living/simple_animal/slime/proc/make_large()
	if(is_large)
		return
	is_large = TRUE
	update_icon()
	update_name()

/mob/living/simple_animal/slime/proc/update_name()
	if(docile) // Docile slimes are generally named, so we shouldn't mess with it.
		return
	name = "[slime_color.Join(" ")][is_large ? " largo" : ""] [initial(name)] ([number])"
	real_name = name

/mob/living/simple_animal/slime/update_icon()
	if(stat == DEAD)
		icon_state = "[icon_state_override ? "[icon_state_override] slime" : "slime"] [is_large ? "largo" : "baby"] dead"
		set_light(0)
	else
		if(incapacitated(INCAPACITATION_DISABLED))
			icon_state = "[icon_state_override ? "[icon_state_override] slime" : "slime"] [is_large ? "largo" : "baby"] dead"
		else
			icon_state = "[icon_state_override ? "[icon_state_override] slime" : "slime"] [is_large ? "largo" : "baby"][victim ? " eating":""]"

	overlays.Cut()
	if(stat != DEAD)
		var/image/I = image(icon, src, "slime light")
		I.appearance_flags = RESET_COLOR
		overlays += I

		if(shiny)
			I = image(icon, src, "slime shiny")
			I.appearance_flags = RESET_COLOR
			overlays += I

		I = image(icon, src, "aslime-[mood]")
		I.appearance_flags = RESET_COLOR
		overlays += I

		if(glows)
			set_light(3, 2, color)

	if(hat)
		var/hat_state = hat.item_state ? hat.item_state : hat.icon_state
		var/image/I = image('icons/mob/head.dmi', src, hat_state)
		I.pixel_y = -7 // Slimes are small.
		I.appearance_flags = RESET_COLOR
		overlays += I

	if(modifier_overlay) // Restore our modifier overlay.
		overlays += modifier_overlay

/mob/living/simple_animal/slime/proc/update_mood()
	var/old_mood = mood
	if(incapacitated(INCAPACITATION_DISABLED))
		mood = "sad"
	else if(rabid)
		mood = "angry"
	else if(target_mob)
		mood = "mischevous"
	else if(docile)
		mood = ":33"
	else
		mood = ":3"
	if(old_mood != mood)
		update_icon()

// Makes the slime very angry and dangerous.
/mob/living/simple_animal/slime/proc/enrage()
	if(docile)
		return
	rabid = TRUE
	update_mood()
	visible_message("<span class='danger'>\The [src] enrages!</span>")

// Makes the slime safe and harmless.
/mob/living/simple_animal/slime/proc/pacify()
	rabid = FALSE
	docile = TRUE
	hostile = FALSE
	retaliate = FALSE
	cooperative = FALSE

	// If for whatever reason the mob AI decides to try to attack something anyways.
	melee_damage_upper = 0
	melee_damage_lower = 0

	update_mood()

/mob/living/simple_animal/slime/examine(mob/user)
	..()
	if(hat)
		to_chat(user, "It is wearing \a [hat].")

	if(stat == DEAD)
		to_chat(user, "It appears to be dead.")
	else if(incapacitated(INCAPACITATION_DISABLED))
		to_chat(user, "It appears to be incapacitated.")
	else if(rabid)
		to_chat(user, "It seems very, very angry and upset.")
	else if(docile)
		to_chat(user, "It appears to have been pacified.")

/mob/living/simple_animal/slime/water_act(amount) // This is called if a slime enters a water tile.
	adjustBruteLoss(40 * amount)

/mob/living/simple_animal/slime/movement_delay()
	if(bodytemperature >= 330.23) // 135 F or 57.08 C
		return -1	// slimes become supercharged at high temperatures

	. = ..()

	var/health_deficiency = (maxHealth - health)
	if(health_deficiency >= 45)
		. += (health_deficiency / 25)

	if(bodytemperature < 183.222)
		. += (283.222 - bodytemperature) / 10 * 1.75

	. += config.slime_delay

/mob/living/simple_animal/slime/Process_Spacemove()
	return 2

/mob/living/simple_animal/slime/speech_bubble_appearance()
	return "slime"

// Called after they finish eatting someone.
/mob/living/simple_animal/slime/proc/befriend(var/mob/living/friend)
	if(!(friend in friends))
		friends |= friend
		say("[friend]... friend...")

/mob/living/simple_animal/slime/proc/can_command(var/mob/living/commander)
	if(rabid)
		return FALSE
	if(docile)
		return SLIME_COMMAND_OBEY
	if(commander in friends)
		return SLIME_COMMAND_FRIEND
	if(faction == commander.faction)
		return SLIME_COMMAND_FACTION
	return FALSE

/mob/living/simple_animal/slime/proc/give_hat(var/obj/item/clothing/head/new_hat, var/mob/living/user)
	if(!istype(new_hat))
		to_chat(user, "<span class='warning'>\The [new_hat] isn't a hat.</span>")
		return
	if(hat)
		to_chat(user, "<span class='warning'>\The [src] is already wearing \a [hat].</span>")
		return
	else
		user.drop_item(new_hat)
		hat = new_hat
		new_hat.forceMove(src)
		to_chat(user, "<span class='notice'>You place \a [new_hat] on \the [src].  How adorable!</span>")
		update_icon()
		return

/mob/living/simple_animal/slime/proc/remove_hat(var/mob/living/user)
	if(!hat)
		to_chat(user, "<span class='warning'>\The [src] doesn't have a hat to remove.</span>")
	else
		hat.forceMove(get_turf(src))
		user.put_in_hands(hat)
		to_chat(user, "<span class='warning'>You take away \the [src]'s [hat.name].  How mean.</span>")
		hat = null
		update_icon()

/mob/living/simple_animal/slime/proc/drop_hat()
	if(!hat)
		return
	hat.forceMove(get_turf(src))
	hat = null
	update_icon()

/mob/living/simple_animal/slime/get_description_info()
	var/list/lines = list()
	var/intro_line = "Slimes are generally the test subjects of Xenobiology, with different colors having different properties.  \
	They can be extremely dangerous if not handled properly."
	lines.Add(intro_line)
	lines.Add(null) // To pad the line breaks.

	lines.Add(description_info)
	return lines.Join("\n")

