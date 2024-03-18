//New frame type that can link to disposal pipes, for anything that needs pipe linkage

/datum/frame/frame_types/disposal
	name = "Disposal Machine" //So funny thing is. This is handled uniquely by framecode and doesnt spawn a normal frame. Because frame code sucks ass.
	icon_override = 'modular_chomp/icons/obj/machines/disposal.dmi'
	frame_class = FRAME_CLASS_MACHINE

/obj/item/weapon/circuitboard/inserter
	name = "circuit board"

/obj/structure/disposal_frame //Because frame subtypes cant exist. Shitcode.
	name = "pneumatic frame"
	//descrption = ""
	icon = 'modular_chomp/icons/obj/machines/disposal.dmi'
	icon_state = "frame"

	var/obj/item/weapon/circuitboard/circuit = null
	var/list/components = null

	var/structure/disposalpipe/trunk/linked

/obj/structure/disposal_frame/attackby(obj/item/I, mob/user)
	var/turf/T = src.loc
	if(!T.is_plating())
		to_chat(user, "You can only attach the [src] if the floor plating is removed.")
		return

	var/obj/structure/disposalpipe/CP = locate() in T

	if(I.has_tool_quality(TOOL_WRENCH))
		if(CP) // There's something there
			if(!istype(CP,/obj/structure/disposalpipe/trunk))
				to_chat(user, "The [src] requires a trunk underneath it in order to work.")
				return
			else // Nothing under, fuck.
				to_chat(user, "The [src] requires a trunk underneath it in order to work.")
				return
		anchored = TRUE

	else if(I.has_tool_quality(TOOL_WELDER))

	else if(istype(I, /obj/item/weapon/circuitboard) && !circuit)
