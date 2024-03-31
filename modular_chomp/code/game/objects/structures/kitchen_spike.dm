//////Kitchen Spike
#define VIABLE_MOB_CHECK(X) (isliving(X) && !issilicon(X) && !isbot(X))

//Porting TG behavior for the purposes of torturing people that are into that. Done on request because I was bored -Reo

/obj/structure/kitchenspike_frame
	name = "meatspike frame"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spikeframe"
	desc = "The frame of a meat spike."
	density = TRUE
	anchored = FALSE
	//max_integrity = 200 //Doesnt exist. If we port the ability to smash everything, uncomment.

/obj/structure/kitchenspike_frame/attackby(obj/item/I, mob/user)
	add_fingerprint(user)
	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = I
		if(R.get_amount() >= 4)
			R.use(4)
			to_chat(user, span_notice("You add spikes to the frame."))
			var/obj/F = new /obj/structure/kitchenspike(src.loc)
			transfer_fingerprints_to(F)
			qdel(src)
	else if(I.has_tool_quality(TOOL_WELDER))
		var/obj/item/weapon/weldingtool/W = I.get_welder()
		to_chat(user, span_notice("You begin cutting \the [src] apart..."))
		if(W.remove_fuel(0,user))
			visible_message("<span class='notice'>[user] slices apart \the [src].</span>", "<span class='notice'>You cut \the [src] apart with \the [I].</span>", "<span class='italics'>You hear welding.</span>")
			new /obj/item/stack/material/steel(src.loc, 4)
			qdel(src)
		return
	else
		return ..()

/obj/structure/kitchenspike
	name = "meat spike"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spike"
	desc = "A spike for collecting meat from animals."
	density = TRUE
	anchored = TRUE
	buckle_lying = 0
	can_buckle = 1
	//max_integrity = 250 //Same as above. Uncomment when things are universally attackable

/obj/structure/kitchenspike/attack_generic(mob/user)
	return attack_hand(user)

/obj/structure/kitchenspike/attackby(obj/item/weapon/grab/G as obj, mob/user as mob)

	if(!istype(G, /obj/item/weapon/grab) || !ismob(G.affecting))
		return
	if(VIABLE_MOB_CHECK(G.affecting))
		return
	var/mob/living/L = G.affecting
	if(has_buckled_mobs()) //to prevent spam/queing up attacks
		return
	if(L.buckled)
		return
	if(user.pulling != L)
		return
	if(do_mob(user, src, 120))
		playsound(src.loc, 'sound/effects/splat.ogg', 25, 1)
		L.visible_message("<span class='danger'>[user] slams [L] onto the meat spike!</span>",\
		"<span class='danger'>[user] slams you onto the meat spike!</span>",\
		"<span class='italic'>You hear a squishy wet noise.</span>")
		L.forceMove(src.loc)
		L.emote("scream")
		//L.add_splatter_floor() //We dont have this proc at the time of porting. if we ever port it, replace the following proc with this.
		blood_splatter(src, L, TRUE)
		//End of missing proc.
		L.adjustBruteLoss(30)
		L.dir = 2
		buckle_mob(L, forced = 1)
		var/matrix/m180 = matrix(L.transform)
		m180.Turn(180)
		animate(L, transform = m180, time = 3)
		//L.pixel_y = L.get_standard_pixel_y_offset(180) //We dont have this one either. Womp womp.
		L.pixel_y = initial(L.pixel_y)
		//End of missing proc

/obj/structure/kitchenspike/attack_hand(mob/user as mob)
	if (has_buckled_mobs())
		for(var/mob/living/L in buckled_mobs)
			user_unbuckle_mob(L, user)
	/*
	meat--
	new meat_type(get_turf(src))
	if(meat > 1)
		to_chat(user, "You cut some meat from \the [victim_name]'s body.")
	else if(meat == 1)
		to_chat(user, "You remove the last piece of meat from \the [victim_name]!")
		icon_state = "spike"
		occupied = 0
	*/

/obj/structure/kitchenspike/user_buckle_mob(mob/living/M, mob/living/user) //Don't want them getting put on the rack other than by spiking
	return

/obj/structure/kitchenspike/user_unbuckle_mob(mob/living/buckled_mob, mob/living/carbon/human/user)
	if(buckled_mob)
		var/mob/living/M = buckled_mob
		if(M != user)
			M.visible_message("[user] tries to pull [M] free of [src]!",\
			"<span class='notice'>[user] is trying to pull you off [src], opening up fresh wounds!</span>",\
			"<span class='italics'>You hear a squishy wet noise.</span>")
			if(!do_after(user, 30 SECONDS, target = src))
				if(M && M.buckled)
					M.visible_message("[user] fails to free [M]!",\
					span_notice("<span class='notice'>[user] fails to pull you off of [src].</span>"))
				return

		else
			M.visible_message("<span class='warning'>[M] struggles to break free from [src]!</span>",\
			"<span class='notice'>You struggle to break free from [src], exacerbating your wounds! (Stay still for two minutes.)</span>",\
			"<span class='italics'>You hear a wet squishing noise..</span>")
			M.adjustBruteLoss(30)
			if(!do_after(M, 2 MINUTES, target = src))
				if(M && M.buckled)
					to_chat(M, span_warning("You fail to free yourself!"))
				return
		if(!M.buckled)
			return
		release_mob(M)

/obj/structure/kitchenspike/proc/release_mob(mob/living/M)
	var/matrix/m180 = matrix(M.transform)
	m180.Turn(180)
	animate(M, transform = m180, time = 3)
	//M.pixel_y = M.get_standard_pixel_y_offset(180) //Like the ones above. Still dont have it!!
	M.pixel_y =
	//End of missing proc
	M.adjustBruteLoss(30)
	src.visible_message(span_danger("[M] falls free of [src]!"))
	unbuckle_mob(M,force=1)
	M.emote("scream")
	M.AdjustParalysis(20)

/obj/structure/kitchenspike/Destroy()
	if(has_buckled_mobs())
		for(var/mob/living/L in buckled_mobs)
			release_mob(L)
	return ..()

/obj/structure/kitchenspike/deconstruct(disassembled = TRUE)
	if(disassembled)
		var/obj/F = new /obj/structure/kitchenspike_frame(src.loc)
		transfer_fingerprints_to(F)
	else
		new /obj/item/stack/material/steel(src.loc, 4)
	new /obj/item/stack/rods(loc, 4)
	qdel(src)


#undef VIABLE_MOB_CHECK
