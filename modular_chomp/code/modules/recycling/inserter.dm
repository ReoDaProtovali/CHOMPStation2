/**
 * Here's my attempt at making something "entirely" on my own.
 * Entirely being a hapharzard mix of Verkie's vac-pack code, old feeder code and finally disposal outlet code.
 * Half vorny passion project, half industrial desire to automate everything passion project, I hope it leads to some fun scenes.
 * -Reo
 */

/obj/structure/disposal_machinery/inserter
	name = "pneumatic inserter"
	desc = "a machine intended to assist with logistics by automatically sending whatever gets piped into it into whatever it's tube is stuck into"
	icon = 'icons/obj/pipes/disposal.dmi'
	icon_state = "outlet" //Temporary...

	var/attached = null		//What we're attached to
	var/output_dest = null	//Where stuff goes
	var/clogged = FALSE		//Glogged

	var/list/insertable = list(		//List of machines that this can insert into, due to each machine probably having a more complex
		/obj/machinery/autolathe	//system of accessing what it uses than just looking in it's contents.
	)

/obj/machinery/disposal_machinery/inserter/Initialize()
	. = ..()

/obj/machinery/disposal_machinery/inserter/MouseDrop(over_object, src_location) // Half stolen from feeder.dm
	..()

	if(!isliving(usr))
		return

	if(attached == over_object)
		attached = null
		visible_message("the outlet tube is pulled out of [over_object]!")
		update_icon()
		return

	if(in_range(src, usr) && get_dist(over_object, src) <= 1)
		if(istype(over_object, /mob/living))	//For fun...
			var/mob/living/target = over_object
			if(!is_vore_predator(target) || !target.feeding)	//Gotta be into it...
				to_chat(usr, "[target] isnt able to be fed")
				return
			var/confirm = tgui_alert(usr, "[target == usr ? "Shove the tube in yourself?" : "Shove the tube in [target]?"]", "Confirmation", list("Yes!", "Cancel"))
			if(!confirm == "Yes!")
				return
			var/obj/belly/B = tgui_input_list(usr, "Which belly?", "Select A Belly", target.vore_organs)
			if(!istype(B))
				return
			output_dest = B

		if(insertable.Find(over_object))	//For industry...
			output_dest = null // later when im not lazy

	else
		to_chat(usr, "The outlet tube cant be inserted into that")
		return

/obj/machinery/disposal_machinery/inserter/eject(var/obj/structure/disposalholder/H)
	. = ..()

	if(clogged) //We wont send our contents anywhere if we're clogged
		playsound(src, "sound/machines/warning-buzzer.ogg")
		visible_message("\the [src] shudders for a moment as it tries to release something")
		for(var/atom/movable/AM in H)
			sleep(1)
			playsound(src, "sound/effects/clang.ogg")
			AM.forceMove(src.contents) //Wecome to the party!

	if(!attached) //If it's not attached to anything, it acts like a disposal outlet. But kinda sprays stuff around.
		sleep(20)
		//visible_message("<span class='warning'>The [src]'s tube flails wildly before ejecting a load of stuff!") //Maybe? Could get spammy.
		for(var/atom/movable/AM in H)//
			AM.forceMove(src.loc)
			AM.pipe_eject(dir)
			spawn(5)
				AM.throw_at(get_offset_target_turf(target, rand(-1,1), rand(-1,1)), (launch_dist + rand(-2,2)))
		qdel(H)
		return

	for(var/atom/movable/AM in H) //If we didnt just shoot out our junk, store it so it can be sent wherever it needs to go
		AM.forceMove(src.contents)

	if(istype(attached, /mob/living)) //We're attached to someone, send our stuff to belly
		sleep(10) //Slight delay before being dunked into guts
		playsound(src, "sound/rakshasa/corrosion3.ogg")
		for(var/atom/movable/AM in src.contents)
			if(istype(AM, /mob/living))
				var/mob/living/snack = AM
				if(!snack.can_be_drop_prey || !snack.devourable) // living snacks need to be willing to be gutdunked
					clogged = TRUE
					continue
			AM.forceMove(output_dest) //In they go!
		qdel(H)
