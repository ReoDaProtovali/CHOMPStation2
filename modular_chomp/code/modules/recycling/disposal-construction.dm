//New frame type that can link to disposal pipes, for anything that needs pipe linkage

/obj/structure/frame/disposal_frame //For mapping...
	name = "pneumatic frame"
	frame_type = new /datum/frame/frame_types/disposal

/datum/frame/frame_types/disposal
	name = "Disposal Machine"
	icon_override = 'modular_chomp/icons/obj/machines/disposal.dmi'
	frame_class = FRAME_CLASS_MACHINE

/obj/item/weapon/circuitboard/inserter
	name = "circuit board"
