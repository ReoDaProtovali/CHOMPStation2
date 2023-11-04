/obj/machinery/button/buttonthatmakesyoushadekinfood
	name = "button that makes you shadekin food"
	desc = "Pressing this button will summon a shadekin who will promptly show you what it's stomach looks like."

/obj/machinery/button/buttonthatmakesyoushadekinfood/attack_hand(var/mob/living/user as mob)
	. = ..()
	//Copied from Smites.dm and adapted for automatic button use. Shadekin feeder.
	var/list/kin_types = list(
		/mob/living/simple_mob/shadekin/red/dark,
		/mob/living/simple_mob/shadekin/red/white,
		/mob/living/simple_mob/shadekin/red/brown,
		/mob/living/simple_mob/shadekin/blue/dark,
		/mob/living/simple_mob/shadekin/blue/white,
		/mob/living/simple_mob/shadekin/blue/brown,
		/mob/living/simple_mob/shadekin/purple/dark,
		/mob/living/simple_mob/shadekin/purple/white,
		/mob/living/simple_mob/shadekin/purple/brown,
		/mob/living/simple_mob/shadekin/yellow/dark,
		/mob/living/simple_mob/shadekin/yellow/white,
		/mob/living/simple_mob/shadekin/yellow/brown,
		/mob/living/simple_mob/shadekin/green/dark,
		/mob/living/simple_mob/shadekin/green/white,
		/mob/living/simple_mob/shadekin/green/brown,
		/mob/living/simple_mob/shadekin/orange/dark,
		/mob/living/simple_mob/shadekin/orange/white,
		/mob/living/simple_mob/shadekin/orange/brown,
		/mob/living/simple_mob/shadekin/blue/rivyr)
	var/kin_type = pick(kin_types)
	if(!kin_type || !user)
		message_admins("it's kin/user glogged")
		to_world("Shadekin: [kin_type], User: [user]")
		return

	var/turf/Tt = get_turf(user)

	if(user.loc != Tt)
		message_admins("it's turf glogged")
		return //Can't nom when not exposed

	//Begin abuse
	user.transforming = TRUE //Cheap hack to stop them from moving
	user.devourable = TRUE //If you press the button you WILL be shadekin food. why else would you press it?
	user.can_be_drop_prey = TRUE //if this was a serious PR i'd not do this kinda thing, buuuut womp womp!
	var/mob/living/simple_mob/shadekin/shadekin = new kin_type(Tt)
	shadekin.real_name = shadekin.name
	shadekin.init_vore()
	shadekin.can_be_drop_pred = TRUE
	shadekin.dir = SOUTH
	shadekin.ability_flags |= 0x1
	shadekin.phase_shift() //Homf
	shadekin.energy = initial(shadekin.energy)
	//For fun
	sleep(1 SECOND)
	shadekin.dir = WEST
	sleep(1 SECOND)
	shadekin.dir = EAST
	sleep(1 SECOND)
	shadekin.dir = SOUTH
	sleep(1 SECOND)
	shadekin.audible_message("<b>[shadekin]</b> belches loudly!", runemessage = "URRRRRP")
	sleep(2 SECONDS)
	shadekin.phase_shift()
	user.transforming = FALSE //Undo cheap hack

	//Permakin'd
	to_chat(user,"<span class='danger'>You're carried off into The Dark by the [shadekin]. Who knows if you'll find your way back?</span>")
	user.ghostize()
	qdel(user)
	qdel(shadekin)
