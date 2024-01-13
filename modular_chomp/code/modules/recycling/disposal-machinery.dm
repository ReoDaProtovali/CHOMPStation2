//Special type of frame that connects to disposal pipes
/obj/machinery/disposal_machinery
	name = "pneumatic machine"

	var/linked //The trunk this is linked to. Might not be used.

/**
 * Called when this machine receives a disposal holder from an underlying disposal trunk.
 */
/obj/machinery/disposal_machinery/proc/eject(var/obj/structure/disposalholder/H)
	if(!H)
		return
	H.vent_gas(src.loc)
