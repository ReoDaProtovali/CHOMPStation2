//Silicon Swoopies!
/mob/living/silicon/robot/swoopie
	icon = 'modular_chomp/icons/mob/swoopie/swoopie.dmi'
	icon_state = "swoopie"
	modtype = "swoopie"
	lawupdate = 0

/mob/living/silicon/robot/swoopie/New()
	if(!cell)
		cell = new /obj/item/weapon/cell/hyper(src) // For storing all the power produced from churning all that junk!
		cell.charge = 10000 // But also starting at a low capacity
	..()

/mob/living/silicon/robot/swoopie/init()
	aiCamera = new/obj/item/device/camera/siliconcam/robot_camera(src)

	mmi = new /obj/item/device/mmi/digital/robot(src) //Simple dronebirbs
	module = new /obj/item/weapon/robot_module/robot/swoopie(src)
	cut_overlays()
	init_id()

	updatename("SWOOPIE XL")

/obj/item/weapon/robot_module/robot/swoopie
	name = "SWOOPIE XL Module"
	channels = "Service"
	sprites = list(
		"Swoopie" = "swoopie"
	)

	can_be_pushed = 0

/obj/item/weapon/robot_module/robot/swoopie/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/device/vac_attachment/swoopie(src)
	src.modules += new /obj/item/weapon/storage/bag/trash(src)
	src.modules += new /obj/item/device/lightreplacer(src)

	R.icon = 'modular_chomp/icons/mob/swoopie/swoopie.dmi'
	R.wideborg_dept = 'modular_chomp/icons/mob/swoopie/swoopie.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.icon_state = "swoopie"
	R.ui_style_vr = TRUE
	R.pixel_x = -16
	R.old_x = -16
	R.default_pixel_x = -16
	pto_type = PTO_CIVILIAN
	R.vore_capacity_ex = list("stomach" = 1, "neck1" = 1, "neck2" = 1, "neck3" = 1, "neck4" = 1)
	R.vore_fullness_ex = list("stomach" = 0, "neck1" = 0, "neck2" = 0, "neck3" = 0, "neck4" = 0)
	R.vore_icon_bellies = list("stomach", "neck1", "neck2", "neck3", "neck4")
	R.dogborg = TRUE
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	R.adminbus_trash = TRUE

/mob/living/silicon/robot/swoopie/speech_bubble_appearance()
	return "synthetic_evil"
