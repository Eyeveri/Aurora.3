
/mob/living/LateLogin()
	..()
	//Mind updates
	mind_initialize()	//updates the mind (or creates and initializes one if one doesn't exist)
	mind.active = 1		//indicates that the mind is currently synced with a client
	//If they're SSD, remove it so they can wake back up.
	update_antag_icons(mind)
	reset_death_timers()

	// Clear our cosmetic/sound weather cooldowns.
	var/obj/abstract/weather_system/weather = get_affecting_weather()

	var/mob_ref = WEAKREF(src)
	if(istype(weather))
		weather.mob_shown_weather -= mob_ref
		weather.mob_shown_wind    -= mob_ref
	GLOB.current_mob_ambience   -= mob_ref

	//Psionic
	if(psi)
		psi.update(TRUE)

	//login during ventcrawl
	if(is_ventcrawling && istype(loc, /obj/machinery/atmospherics)) //attach us back into the pipes
		remove_ventcrawl()
		add_ventcrawl(loc)

	if(ability_master)
		ability_master.toggle_open(2)
		client.screen -= ability_master

	return .
