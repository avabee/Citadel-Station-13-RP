/mob/living/simple_animal/slime/proc/adjust_nutrition(input)
	nutrition = between(0, nutrition + input, get_max_nutrition())

	if(input > 0)
		if(prob(input * 2) && (nutrition < (get_max_nutrition() + get_hunger_nutrition())/2)) // halfway between hungry and full, you start healing toxins
			adjustToxLoss(-10)


/mob/living/simple_animal/slime/proc/get_max_nutrition() // Can't go above it
	if(is_large)
		return 1200
	return 1000

/mob/living/simple_animal/slime/proc/get_hunger_nutrition() // Below it we will always eat
	if(is_large)
		return 600
	return 500

/mob/living/simple_animal/slime/proc/get_starve_nutrition() // Below it we will eat before everything else
	if(is_large)
		return 300
	return 200

/mob/living/simple_animal/slime/proc/handle_nutrition()
	if(docile)
		return
	if(prob(15))
		adjust_nutrition(-1 - is_large)

	if(nutrition <= get_starve_nutrition())
		handle_starvation()

/mob/living/simple_animal/slime/proc/handle_starvation()
	if(nutrition < get_starve_nutrition() && !client) // if a slime is starving, it starts losing its friends
		if(prob(5))
			rabid = TRUE
		if(friends.len && prob(1))
			var/mob/nofriend = pick(friends)
			if(nofriend)
				friends -= nofriend
				say("[nofriend]... food now...")

	if(nutrition <= 0)
		rabid = TRUE
		adjustToxLoss(rand(1,3))
		if(client && prob(5))
			to_chat(src, "<span class='danger'>You are starving!</span>")

/mob/living/simple_animal/slime/handle_regular_status_updates()
	if(stat != DEAD)
		handle_nutrition()

		if(prob(30))
			adjustOxyLoss(-1)
			adjustToxLoss(-1)
			adjustFireLoss(-1)
			adjustCloneLoss(-1)
			adjustBruteLoss(-1)

		if(victim)
			handle_consumption()

		handle_stuttering()

	..()


// This is to make slime responses feel a bit more natural and not instant.
/mob/living/simple_animal/slime/proc/delayed_say(var/message, var/mob/target)
	spawn(rand(1 SECOND, 2 SECONDS))
		if(target)
			face_atom(target)
		say(message)

//Commands, reactions, etc
/mob/living/simple_animal/slime/hear_say(var/message, var/verb = "says", var/datum/language/language = null, var/alt_name = "", var/italics = 0, var/mob/speaker = null, var/sound/speech_sound, var/sound_vol)
	..()
	if((findtext(message, num2text(number)) || findtext(message, name) || findtext(message, "slimes"))) // Talking to us

		// First make sure it's not just another slime repeating things.
		if(istype(speaker, /mob/living/simple_animal/slime))
			if(!speaker.client)
				return

		//Are all slimes being referred to?
		var/mass_order = 0
		if(findtext(message, "slimes"))
			mass_order = 1

		// Say hello back.
		if(findtext(message, "hello") || findtext(message, "hi") || findtext(message, "greetings"))
			delayed_say(pick("Hello...", "Hi..."), speaker)

		// Follow request.
		if(findtext(message, "follow") || findtext(message, "come with me"))
			if(!can_command(speaker))
				delayed_say(pick("No...", "I won't follow..."), speaker)
				return

			delayed_say("Yes... I follow \the [speaker]...", speaker)
			set_follow(speaker)
			FollowTarget()

		// Stop request.
		if(findtext(message, "stop") || findtext(message, "halt") || findtext(message, "cease"))
			if(victim) // We're being asked to stop eatting someone.
				if(!can_command(speaker))
					delayed_say("No...", speaker)
					return
				else
					delayed_say("Fine...", speaker)
					stop_consumption()

			if(target_mob) // We're being asked to stop chasing someone.
				if(!can_command(speaker))
					delayed_say("No...", speaker)
					return
				else
					delayed_say("Fine...", speaker)
					LoseTarget()

			if(follow_mob) // We're being asked to stop following someone.
				if(can_command(speaker) == SLIME_COMMAND_FRIEND || follow_mob == speaker)
					delayed_say("Yes... I'll stop...", speaker)
					LoseFollow()
				else
					delayed_say("No... I'll keep following \the [follow_mob]...", speaker)

		// Murder request
		if(findtext(message, "harm") || findtext(message, "kill") || findtext(message, "murder") || findtext(message, "eat") || findtext(message, "consume"))
			if(can_command(speaker) < SLIME_COMMAND_FACTION)
				delayed_say("No...", speaker)
				return

			for(var/mob/living/L in view(7, src) - list(src, speaker))
				if(L == src)
					continue // Don't target ourselves.
				var/list/valid_names = splittext(L.name, " ") // Should output list("John", "Doe") as an example.
				for(var/line in valid_names) // Check each part of someone's name.
					if(findtext(message, lowertext(line))) // If part of someone's name is in the command, the slime targets them if allowed to.
						if(!(mass_order && line == "slime"))	//don't think random other slimes are target
							if(special_target_check(L))
								delayed_say("Okay... I attack \the [L]...", speaker)
								LoseFollow()
								set_target(L, 1)
								return
							else
								delayed_say("No... I won't attack \the [L].", speaker)
								return
			// If we're here, it couldn't find anyone with that name.
			delayed_say("No... I don't know who to attack...", speaker)
