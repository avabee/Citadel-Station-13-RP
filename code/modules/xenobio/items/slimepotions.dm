// These things get applied to slimes to do things.

/obj/item/slimepotion
	name = "slime agent"
	desc = "A flask containing strange, mysterious substances excreted by a slime."
	icon = 'icons/obj/chemical.dmi'
	w_class = ITEMSIZE_TINY
	origin_tech = list(TECH_BIO = 4)

// This is actually applied to an extract, so no attack() overriding needed.
/obj/item/slimepotion/enhancer
	name = "extract enhancer agent"
	desc = "A potent chemical mix that will give a slime extract an additional two uses."
	icon_state = "potpurple"
	description_info = "This will even work on inert slime extracts, if it wasn't enhanced before.  Extracts enhanced cannot be enhanced again."

// Makes slimes more stupider.
/obj/item/slimepotion/sedative
	name = "slime sedative agent"
	desc = "A potent chemical mix that will make a slime less reactive."
	icon_state = "potcyan"
	description_info = "The slime needs to be alive for this to work.  It will make a slime less tactically adept."

/obj/item/slimepotion/sedative/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!istype(M))
		to_chat(user, "<span class='warning'>The sedative only works on slimes!</span>")
		return ..()
	if(M.stat == DEAD)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return ..()

	to_chat(user, "<span class='notice'>You feed the slime the sedative..</span>")
	M.optimal_combat = 0
	playsound(src, 'sound/effects/bubbles.ogg', 50, 1)
	qdel(src)


// The opposite, makes the slime more tactically adept.
/obj/item/slimepotion/nootropic
	name = "slime nootropic agent"
	desc = "A potent chemical mix that will increase a slime's mental acuity."
	description_info = "The slime needs to be alive for this to work.  It will increase a slime's tactical awareness."
	icon_state = "potred"

/obj/item/slimepotion/nootropic/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!istype(M))
		to_chat(user, "<span class='warning'>The nootropic only works on slimes!</span>")
		return ..()
	if(M.stat == DEAD)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return ..()

	to_chat(user, "<span class='notice'>You feed the slime the nootropic. It is now more tactically aware.</span>")
	M.optimal_combat = 1
	playsound(src, 'sound/effects/bubbles.ogg', 50, 1)
	qdel(src)


// Makes the slime friendly forever.
/obj/item/slimepotion/docility
	name = "docility agent"
	desc = "A potent chemical mix that nullifies a slime's hunger, causing it to become docile and tame.  It might also work on other creatures?"
	icon_state = "potlightpink"
	description_info = "The target needs to be alive, not already passive, and have animal-like intelligence."

/obj/item/slimepotion/docility/attack(mob/living/simple_animal/M, mob/user)
	if(!istype(M))
		to_chat(user, "<span class='warning'>The agent only works on creatures!</span>")
		return ..()
	if(M.stat == DEAD)
		to_chat(user, "<span class='warning'>\The [M] is dead!</span>")
		return ..()

	// Slimes.
	if(istype(M, /mob/living/simple_animal/slime))
		var/mob/living/simple_animal/slime/S = M
		if(S.docile)
			to_chat(user, "<span class='warning'>The slime is already docile!</span>")
			return ..()

		S.pacify()
		S.nutrition = 700
		to_chat(M, "<span class='warning'>You absorb the agent and feel your intense desire to feed melt away.</span>")
		to_chat(user, "<span class='notice'>You feed the slime the agent, removing its hunger and calming it.</span>")

	// Simple Animals.
	else if(istype(M, /mob/living/simple_animal))
		var/mob/living/simple_animal/SA = M
		if(SA.intelligence_level > SA_ANIMAL) // So you can't use this on Russians/syndies/hivebots/etc.
			to_chat(user, "<span class='warning'>\The [SA] is too intellient for this to affect them.</span>")
			return ..()
		if(!SA.hostile)
			to_chat(user, "<span class='warning'>\The [SA] is already passive!</span>")
			return ..()

		SA.hostile = FALSE
		to_chat(M, "<span class='warning'>You consume the agent and feel a serene sense of peace.</span>")
		to_chat(user, "<span class='notice'>You feed \the [SA] the agent, calming it.</span>")

	playsound(src, 'sound/effects/bubbles.ogg', 50, 1)
	M.LoseTarget() // So hostile things stop attacking people even if not hostile anymore.
	var/newname = copytext(sanitize(input(user, "Would you like to give \the [M] a name?", "Name your new pet", M.name) as null|text),1,MAX_NAME_LEN)

	if(newname)
		M.name = newname
		M.real_name = newname
	qdel(src)


// Makes slimes make more extracts.
/obj/item/slimepotion/steroid
	name = "slime steroid agent"
	desc = "A potent chemical mix that will make a largo slime physically stronger."
	description_info = "The slime needs to be alive and a largo for this to work.  It will increase the amount of health to 150%."
	icon_state = "potpurple"

/obj/item/slimepotion/steroid/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!istype(M))
		to_chat(user, "<span class='warning'>The steroid only works on slimes!</span>")
		return ..()
	if(M.stat == DEAD)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return ..()
	if(!M.is_large) //Can't steroidify adults
		to_chat(user, "<span class='warning'>Only largo slimes can use the steroid!</span>")
		return ..()
	if(!M.steroid)
		to_chat(user, "<span class='warning'>You can't overdose slimes on steroids!</span>")
		return ..()

	to_chat(user, "<span class='notice'>You feed the slime the steroid. It will now produce one more extract.</span>")
	M.maxHealth *= 1.5
	M.steroid = TRUE
	playsound(src, 'sound/effects/bubbles.ogg', 50, 1)
	qdel(src)


// Makes a promethean cube from a slime.
/obj/item/slimepotion/sapience
	name = "slime sapience agent"
	desc = "A potent chemical mix that makes the slime condense into a promethean core."
	description_info = "The slime needs to be alive for this to work."
	icon_state = "potpink"

/obj/item/slimepotion/sapience/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!istype(M))
		to_chat(user, "<span class='warning'>The agent only works on slimes!</span>")
		return ..()
	if(M.stat == DEAD)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return ..()

	to_chat(user, "<span class='notice'>You feed the slime the sapience agent, and it condenses into a cube.")
	var/obj/item/slime_cube/SC = new()
	SC.color = M.color
	qdel(M)
	playsound(src, 'sound/effects/bubbles.ogg', 50, 1)
	qdel(src)

// Makes slimes not kill (most) humanoids but still fight spiders/carp/bears/etc.
/obj/item/slimepotion/loyalty
	name = "slime loyalty agent"
	desc = "A potent chemical mix that makes an animal deeply loyal to the species of whoever applies this, and will attack threats to them."
	description_info = "The slime or other animal needs to be alive for this to work.  The slime this is applied to will have their 'faction' change to \
	the user's faction, which means the slime will attack things that are hostile to the user's faction, such as carp, spiders, and other slimes."
	icon_state = "potred"

/obj/item/slimepotion/loyalty/attack(mob/living/simple_animal/M, mob/user)
	if(!istype(M))
		to_chat(user, "<span class='warning'>The agent only works on animals!</span>")
		return ..()
	if(M.intelligence_level > SA_ANIMAL) // So you can't use this on Russians/syndies/hivebots/etc.
		to_chat(user, "<span class='warning'>\The [M] is too intelligent for this to affect them.</span>")
		return ..()
	if(M.stat == DEAD)
		to_chat(user, "<span class='warning'>The animal is dead!</span>")
		return ..()
	if(M.faction == user.faction)
		to_chat(user, "<span class='warning'>\The [M] is already loyal to your species!</span>")
		return ..()

	to_chat(user, "<span class='notice'>You feed \the [M] the agent. It will now try to murder things that want to murder you instead.</span>")
	to_chat(M, "<span class='notice'>\The [user] feeds you \the [src], and feel that the others will regard you as an outsider now.</span>")
	M.faction = user.faction
	M.attack_same = FALSE
	M.LoseTarget() // So hostile things stop attacking people even if not hostile anymore.
	playsound(src, 'sound/effects/bubbles.ogg', 50, 1)
	qdel(src)


// User befriends the slime with this.
/obj/item/slimepotion/friendship
	name = "slime friendship agent"
	desc = "A potent chemical mix that makes an animal deeply loyal to the the specific entity which feeds them this agent."
	description_info = "The slime or other animal needs to be alive for this to work.  The slime this is applied to will consider the user \
	their 'friend', and will never attack them.  This might also work on other things besides slimes."
	icon_state = "potlightpink"

/obj/item/slimepotion/friendship/attack(mob/living/simple_animal/M, mob/user)
	if(!istype(M))
		to_chat(user, "<span class='warning'>The agent only works on animals!</span>")
		return ..()
	if(M.intelligence_level > SA_ANIMAL) // So you can't use this on Russians/syndies/hivebots/etc.
		to_chat(user, "<span class='warning'>\The [M] is too intellient for this to affect them.</span>")
		return ..()
	if(M.stat == DEAD)
		to_chat(user, "<span class='warning'>The animal is dead!</span>")
		return ..()
	if(user in M.friends)
		to_chat(user, "<span class='warning'>\The [M] is already loyal to you!</span>")
		return ..()

	to_chat(user, "<span class='notice'>You feed \the [M] the agent. It will now be your best friend.</span>")
	to_chat(M, "<span class='notice'>\The [user] feeds you \the [src], and feel that \the [user] wants to be best friends with you.</span>")
	if(isslime(M))
		var/mob/living/simple_animal/slime/S = M
		S.befriend(user)
	else
		M.friends.Add(user)
	M.LoseTarget() // So hostile things stop attacking people even if not hostile anymore.
	playsound(src, 'sound/effects/bubbles.ogg', 50, 1)
	qdel(src)


// Feeds the slime instantly.
/obj/item/slimepotion/feeding
	name = "slime feeding agent"
	desc = "A potent chemical mix that will instantly sate the slime's hunger."
	description_info = "The slime needs to be alive for this to work.."
	icon_state = "potyellow"

/obj/item/slimepotion/feeding/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!istype(M))
		to_chat(user, "<span class='warning'>The feeding agent only works on slimes!</span>")
		return ..()
	if(M.stat == DEAD)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return ..()

	to_chat(user, "<span class='notice'>You feed the slime the feeding agent.</span>")
	M.nutrition = M.get_max_nutrition()
	playsound(src, 'sound/effects/bubbles.ogg', 50, 1)
	qdel(src)
